Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSCRTQC>; Mon, 18 Mar 2002 14:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSCRTP4>; Mon, 18 Mar 2002 14:15:56 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23263 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S292231AbSCRTPp>; Mon, 18 Mar 2002 14:15:45 -0500
Date: Mon, 18 Mar 2002 12:15:25 -0700
Message-Id: <200203181915.g2IJFPe22729@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C963954.87168F84@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Richard Gooch wrote:
> > 
> > Andrew Morton writes:
> > > Note that it applies to a file descriptor.  If
> > > posix_fadvise(FADV_DONTNEED) is called against a file descriptor,
> > > and someone else has an fd open against the same file, that other
> > > user gets their foot shot off.  That's OK.
> > 
> > Let me verify that I understand what you're saying. Process A and B
> > independently open the file. The file is already in the cache (because
> > other processes regularly read this file). Process A is slowly reading
> > stuff. Process B does FADV_DONTNEED on the whole file. The pages are
> > dropped.
> > 
> > You're saying this is OK? How about this DoS attack:
> >         int fd = open ("/lib/libc.so", O_RDONLY, 0);
> >         while (1) {
> >                 posix_fadvise (fd, 0, 0, FADVISE_DONTNEED);
> >                 sleep (1);
> >         }
> > 
> > Let me see that disc head move! Wheeee!
> > 
> 
> POSIX_FADV_DONTNEED could only unmap pages from the caller's
> VMA's, so the problem would only affect other processes which
> share the same mm - CLONE_MM threads.
> 
> If some other process has a reference on the pages then they
> wouldn't get unmapped as a result of this.  It's the same
> as madvise(MADV_DONTNEED).

OK, I misparsed what you had said. Good.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
