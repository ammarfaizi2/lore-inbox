Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTB1SFK>; Fri, 28 Feb 2003 13:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTB1SFK>; Fri, 28 Feb 2003 13:05:10 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22416 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267921AbTB1SFG>;
	Fri, 28 Feb 2003 13:05:06 -0500
Message-Id: <200302281814.h1SIEB42005202@eeyore.valparaiso.cl>
To: Kevin Corry <corryk@us.ibm.com>
cc: Joe Perches <joe@perches.com>, "LKML" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface 
In-Reply-To: Your message of "Fri, 28 Feb 2003 08:59:25 MDT."
             <03022808592509.05199@boiler> 
Date: Fri, 28 Feb 2003 15:14:11 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <corryk@us.ibm.com> said:
> On Friday 28 February 2003 08:32, you wrote:
> > On Thu, 2003-02-27 at 14:05, Kevin Corry wrote:
> > > Unfortunately, Linus seems to have committed that patch already. So here
> > > is a patch to fix just that line.
> > >
> > > Thanks for catching that.
> >
> > Third time, strlen isn't necessary, it can be done at compile time.
> >
> > --- a/drivers/md/dm-ioctl.c     2003/02/27 16:29:58
> > +++ b/drivers/md/dm-ioctl.c     2003/02/27 17:21:54
> > @@ -174,7 +174,7 @@
> >  static int register_with_devfs(struct hash_cell *hc)
> >  {
> >         struct gendisk *disk = dm_disk(hc->md);
> > -       char *name = kmalloc(DM_NAME_LEN + strlen(DM_DIR) + 1);
> > +       char *name = kmalloc(DM_NAME_LEN + sizeof(DM_DIR));
> >         if (!name) {
> >                 return -ENOMEM;
> >         }
> 
> Sorry, I sent the last patch before I got your email.
> 
> Also, the "+1" is still necessary, even if we switch to sizeof. The sprintf 
> call that follows copies DM_DIR, followed by a slash, followed by the name 
> from the hash table into the allocated string. The "+1" is for the slash in 
> the middle. The terminating NULL character is accounted for in
> DM_NAME_LEN.

Then it was broken before.

sizeof("1234") == strlen("1234") + 1 == 5
