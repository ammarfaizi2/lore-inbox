Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287786AbSAXRaf>; Thu, 24 Jan 2002 12:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288655AbSAXRaP>; Thu, 24 Jan 2002 12:30:15 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49042 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287786AbSAXRaH>; Thu, 24 Jan 2002 12:30:07 -0500
Date: Thu, 24 Jan 2002 10:29:49 -0700
Message-Id: <200201241729.g0OHTn215645@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Rainer Krienke <krienke@uni-koblenz.de>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <20020124121649.A7722@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com>
	<200201221523.g0MFNst03011@bliss.uni-koblenz.de>
	<20020122124518.B27968@devserv.devel.redhat.com>
	<200201240858.g0O8wnH03603@bliss.uni-koblenz.de>
	<20020124121649.A7722@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:
> > From: Rainer Krienke <krienke@uni-koblenz.de>
> > Date: Thu, 24 Jan 2002 09:58:48 +0100
> 
> > diff -Naur linux-2.4.17.orig/fs/super.c linux-2.4.17/fs/super.c
> > --- linux-2.4.17.orig/fs/super.c        Fri Dec 21 18:42:03 2001
> > +++ linux-2.4.17/fs/super.c     Thu Jan 24 08:23:05 2002
> > @@ -489,13 +489,13 @@
> >   * filesystems which don't use real block-devices.  -- jrs
> >   */
> > 
> > -static unsigned long unnamed_dev_in_use[256/(8*sizeof(unsigned long))];
> > +static unsigned long unnamed_dev_in_use[4096/(8*sizeof(unsigned long))];
> > 
> >  kdev_t get_unnamed_dev(void)
> >  {
> >         int i;
> > 
> > -       for (i = 1; i < 256; i++) {
> > +       for (i = 1; i < 4096; i++) {
> >                 if (!test_and_set_bit(i,unnamed_dev_in_use))
> >                         return MKDEV(UNNAMED_MAJOR, i);
> >         }
> >[...]
> > mount a very high number only limited by the bitmap unnamed_dev_in_use of NFS 
> > directories. The problems are:
> 
> Rainer, you missed the point. Nobody cares about small things
> such as "cannot start nfsd" while your 4096 mounts patch
> simply CORRUPTS YOUR DATA TO HELL.
> 
> If you need more than 1200 mounts, you have to add more majors
> to my patch. There is a number of them between 115 and 198.
> I suspect scalability problems may become evident
> with this approach, but it will work.
> 
> Trond asked if I requested numbers from HPA, and the answer is no,
> because I wanted the patch in circulation for a while before it
> is worth bothering. Also, I heard that LANA is closed anyways.

You can use devfs_alloc_major() to safely grab unassigned majors.
If necessary, I can move this to a generic area.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
