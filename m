Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVEMRZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVEMRZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVEMRZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:25:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62644 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262448AbVEMRZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:25:02 -0400
Date: Fri, 13 May 2005 18:25:14 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050513172514.GJ1150@parcelfarce.linux.theplanet.co.uk>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu> <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk> <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:17:39PM +0200, Miklos Szeredi wrote:
> > > Bind mount from a foreign namespace results in
> > 
> > ... -EINVAL
> 
> Wrong answer.  Look again, you wrote the code, so you _should_ know ;)

static inline int check_mnt(struct vfsmount *mnt)
{
        return mnt->mnt_namespace == current->namespace;
}

static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
{
        struct nameidata old_nd;
        struct vfsmount *mnt = NULL;
	/* no changes of mnt */
	err = -EINVAL;
	if (check_mnt(nd->mnt) && ... ) {
		/* assigns to mnt */
	}
	if (mnt) {
		/* assigns to err */
	}
        up_write(&current->namespace->sem);
        path_release(&old_nd);
        return err;
}

Care to explain how that would not give -EINVAL?
