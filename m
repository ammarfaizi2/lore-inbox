Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSCRQlb>; Mon, 18 Mar 2002 11:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCRQlW>; Mon, 18 Mar 2002 11:41:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:3295 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288748AbSCRQlM>; Mon, 18 Mar 2002 11:41:12 -0500
Date: Mon, 18 Mar 2002 09:41:01 -0700
Message-Id: <200203181641.g2IGf1M20210@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C959D55.14768770@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Note that it applies to a file descriptor.  If
> posix_fadvise(FADV_DONTNEED) is called against a file descriptor,
> and someone else has an fd open against the same file, that other
> user gets their foot shot off.  That's OK.

Let me verify that I understand what you're saying. Process A and B
independently open the file. The file is already in the cache (because
other processes regularly read this file). Process A is slowly reading
stuff. Process B does FADV_DONTNEED on the whole file. The pages are
dropped.

You're saying this is OK? How about this DoS attack:
	int fd = open ("/lib/libc.so", O_RDONLY, 0);
	while (1) {
		posix_fadvise (fd, 0, 0, FADVISE_DONTNEED);
		sleep (1);
	}

Let me see that disc head move! Wheeee!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
