Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVDAPPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVDAPPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVDAPPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:15:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23524 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262762AbVDAPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:14:58 -0500
Date: Fri, 1 Apr 2005 17:14:57 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       rweight@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Set MS_ACTIVE in isofs_fill_super()
Message-ID: <20050401151457.GC30217@atrey.karlin.mff.cuni.cz>
References: <1112213392.25362.65.camel@russw.beaverton.ibm.com> <20050330123907.10740bc1.akpm@osdl.org> <20050330221947.GA3827@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330221947.GA3827@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 30, 2005 at 12:39:07PM -0800, Andrew Morton wrote:
<snip> 
> > I wonder if it would make more sense for all the ->fill_super callers to
> > set MS_ACTIVE prior to calling ->fill_super(), and clear MS_ACTIVE if
> > fill_super() failed?
> 
> This sounds like a better solution, although filesystems might have to
> handle some operations earlier than they currently expect.
  Actually I've just checked the code and MS_ACTIVE is almost unused -
the only place where it is checked is generic_forget_inode(). So
Andrew's suggestion should be safe (and a quick grep showed that quite
a few filesystems already set MS_ACTIVE in their code)... What really
protects the filesystem from early operations is the fact that its
directory tree is made visible to the rest of the world in
do_add_mount() which is quite after fill_super() has finished.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
