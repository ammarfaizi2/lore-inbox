Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSICDxQ>; Mon, 2 Sep 2002 23:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSICDxP>; Mon, 2 Sep 2002 23:53:15 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:9654 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318643AbSICDxP>; Mon, 2 Sep 2002 23:53:15 -0400
Date: Mon, 2 Sep 2002 23:57:46 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
Message-ID: <20020903035745.GG29452@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	linux-kernel@vger.kernel.org
References: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 07:00:04PM +0100, Anton Altaparmakov wrote:
> Without such icache lookup functionality it is impossible to write inodes
> via the VM page dirty code paths AFAICS. - The only alternative I can see
> is to duplicate the whole icache private to NTFS so that I can perform the
> lookup internally but I think that is silly considering the VFS already
> keeps the inode cache...

Wouldn't you be able to use something like the following code to do ilookup?

Jan


static int dont_set(struct inode *inode, void *data)
{
	return -1;
}

struct inode *ilookup(struct super_block *sb, struct list_head *head,
		      int (*test)(struct inode *, void *), void *data)
{
	return iget5_locked(sb, head, test, dont_set, data);
}
