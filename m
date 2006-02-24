Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWBXB6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWBXB6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBXB6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:58:18 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:54259 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S932350AbWBXB6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:58:17 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-mm1 & 2.6.16-rc1-mm2 (mm5 too) panics
Date: Thu, 23 Feb 2006 20:57:59 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com,
       linux-scsi@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Hans Reiser <reiser@namesys.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <200601280846.23279.edt@aei.ca> <200602041843.28214.edt@aei.ca>
In-Reply-To: <200602041843.28214.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602232058.00130.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.16-rc4-mm1 panics with a zam-597 (fs/reiser4/txnmgr.c) with an rc=-5 

This has been happening since 2.6.16-rc1-mm2.  It makes testing with reiserfs4 impossible here.

I have not been able to figure out how to use bisect etc to find out what is triggering this.  I had
hoped that reversing  "jbd: split checkpoint lists" as per the fix for ocfs2 might help (its in rc4-mm1)
but no such luck.

Does anyone have a suggestion on how I can help find what is broken here?

TIA,
Ed Tomlinson

On Saturday 04 February 2006 18:43, Ed Tomlinson wrote:

> I need some help figuring this one out.  I cannot use git bisect and applying the 2.6.15-1 reiserfs4
> patch does not work with newer 2.6.16 levels - looks like the mutex conversion hits it hard.  Looking
> in mm there are about 50 reiser4 patches...  
> 
> To reproduce this problem I need reiser4 though the issue maybe in libata or scsi.  Does anyone
> have an idea how I can proceed to find what makes newer kernels get io errors which trigger a reiser4
> panic?   The panic is a zam-597 (fs/reiser4/txnmgr.c) with an rc=-5 
> 
> Anyone have a git tree tracking linus with reiser4 patches applied staring before 2.6.15 - if so git 
> bisect could be used to find the change causing the problem.
> 
> One datapoint.  In 2.6.15 + reiser4 2.6.15-1 works fine - the resiser4 filesystem is heavily used with
> no errors.  Smart report no problems with the drive being used.  The libata driver used is sata_nv.
> 
> Please reply to my email - I am only subscribed to lkml.
> 
> Help!
> Ed Tomlinson
> 
> ret = reiser4_write_logs(nr_submitted);
> if (ret < 0)
>     reiser4_panic("zam-597", "write log failed (%ld)\n", ret);
> 
> On Saturday 28 January 2006 08:46, Ed Tomlinson wrote:
> > On Friday 27 January 2006 09:53, you wrote:
> > > Ed Tomlinson wrote:
> > > > Summarizing all this.  There are two problems here.
> > > > 
> > > > 1. reserifs4 panics when it gets io errors - I remember this was an issue that
> > > > needed to be fixed in the R4 code before it moves to mainline...
> > > > 
> > > > 2. Why does a drive which is fine with 2.6.15-rc5-mm3, return a -5 with 2.6.16-mm3
> > > > and above?  Smart reports no problems with the drive hardware.  What has changed 
> > > > in the libata/scsi stacks?
> > > 
> > > That's a long answer.  Could you assist in narrowing down the versions 
> > > which are affected?
> > > 
> > > It would also be useful if you could try vanilla kernels, and help us 
> > > discover whether problems surfaces in 2.6.15, 2.6.15-git[1234], 
> > > 2.6.16-rc1, etc.
> > 
> > Jeff,
> > 
> > I'll see what I can do with git bisect.  Given that reserifs4 is in the picture this may be
> > fun...   I expect it will be a slow process (kernels take 40min to build here).
> > 
> > Thanks
> > Ed Tomlinson
> > 
> > 
> 
> 
