Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRFSIdV>; Tue, 19 Jun 2001 04:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264031AbRFSIdB>; Tue, 19 Jun 2001 04:33:01 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:40341 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264032AbRFSIdA>; Tue, 19 Jun 2001 04:33:00 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 19 Jun 2001 01:32:57 -0700
Message-Id: <200106190832.BAA27959@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [isocompr PATCH]: first comparison with HPA's zisofs (warning: rambling)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I wanted to provide some background on where isocompr
came from make a few encouraging remarks about integrating
this sort of functinality into the stock kernels, but somehow
I've managed to ramble for 60 lines about it.  It's safe to skip
this article if you're in a hurry!

	The genesis of the isocompr code is Eric Youngdale's
Transparent Compression Facility for ISO-9660 at
ftp://tsx-11.mit.edu/pub/linux/BETA/cdrom/private/mkisofs/tcf.tar.gz,
written in Junary 1994 for Linux 0.9x.

	Sometime before February 1998, I ported Eric's code to Linux
2.1.86, adding support for the page cache and making a few changes in
the compressed file format (putting the table of contents at the end so
that gzip could stream its output, and I think removing some unnecessary
header fluff and possibly supporting larger files and different
block sizes).  iso9660-compress-2.0.tar.gz
has been FTPable from ftp://ftp.yggdrasil.com/pub/dist/cdrom/ and
ftp://metalab.unc.edu/pub/Linux/kernel/ since its announcement
on comp.os.linux.development.system in February 1998
(http://groups.google.com/groups?q=iso9660-compress&hl=en&safe=off&rnum=1&ic=1&selm=6cdlme%24ai2%40freya.yggdrasil.com).
I have been updating it and it is in the 2.4.5 build tree at Yggdrasil.
Although I have distributed test CD's that use this system, I believe
the only mass produced CD's that use it are from DemoLinux.

	I've sent people copies of updated versions as they've asked, but I
never really championed integration of this code into the kernel, because
(if memory serves) of some unsolved bug that escapes my recollection.
One of the people was Vincent Balat, one of Professor Di Cosmo's
students working on DemoLinux.  Professor Di Cosmo (and his students?)
have worked on it since then, starting with sending me that bug fix,
and subsequently becoming the place where development was actually
being done on it.

	I vaguely recall that because of a lack of support for 64
bit division and had to restrict block sizes to being a power of two
(not a big practical problem) and then in the course of doing something
for page-based IO support I think I only supported block sizes of
less than or equal to the page size.  So, I am glad to see that Peter's
code supports block sizes bigger than 4kB, as I think this typically
will improve gzip efficiency on objects and binaries by roughly 15%.
The 12 byte headers on each block I do not understand the need for,
since the data length is already known and there is already plenty
of error checking in the CDROM data sectors, but it should only add
about 500kB to a 680MB CD that is compressing 32kB data blocks and
getting a 2:1 compression ratio (i.e., getting 16kB blocks).

	Although the duplication of effort frustrates me slightly, 
I'm glad to see both Professor Di Cosmo and Peter championing
integration of this functionality into the kernel in one form or
another.  It not only makes it possible to distribute much bigger
"live" filesystems on CD or DVD, but also should improve throughput
on slower drives (and there are still lots of slower CD's out there).
I hope this functionality will be integrated into the stock kernels
relatively soon.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
