Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132961AbRDES2Q>; Thu, 5 Apr 2001 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132962AbRDES2G>; Thu, 5 Apr 2001 14:28:06 -0400
Received: from kuroneko.thok.org ([199.103.225.11]:23301 "HELO kuroneko")
	by vger.kernel.org with SMTP id <S132961AbRDES1z>;
	Thu, 5 Apr 2001 14:27:55 -0400
From: "Mark W. Eichin" <eichin@thok.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: buz.c, 6pack.c use nonexistant KMALLOC_MAXSIZE in 2.4.3
Message-Id: <20010405182711.3E1DC13D97@kuroneko>
Date: Thu,  5 Apr 2001 14:27:11 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
buz.c, 6pack.c use nonexistant KMALLOC_MAXSIZE in 2.4.3
[2.] Full description of the problem/report:
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)

in kernel-source-2.4.3:
$ find . -name '*.h' | xargs grep KMALLOC_MAXSIZE
$ find . -name '*.c' | xargs grep KMALLOC_MAXSIZE
./drivers/media/video/buz.c: *   If v4l_bufsize <= KMALLOC_MAXSIZE we use kmalloc
./drivers/media/video/buz.c:            if (v4l_bufsize <= KMALLOC_MAXSIZE) {
./drivers/media/video/buz.c: *   If the requested buffer size is smaller than KMALLOC_MAXSIZE,
./drivers/media/video/buz.c: *   size to KMALLOC_MAXSIZE in that case (which forces contiguous allocation).
./drivers/media/video/buz.c:    alloc_contig = (zr->jpg_bufsize < KMALLOC_MAXSIZE);
./drivers/media/video/buz.c:    alloc_contig = (zr->jpg_bufsize < KMALLOC_MAXSIZE);
./drivers/media/video/buz.c:                    if (zr->need_contiguous && br.size > KMALLOC_MAXSIZE)
./drivers/media/video/buz.c:                            br.size = KMALLOC_MAXSIZE;
./drivers/net/hamradio/6pack.c: if (sixpack_maxdev * sizeof(void*) >= KMALLOC_MAXSIZE) {
$ find ../kernel-source-2.2.19 -name '*.h' | xargs grep KMALLOC_MAXSIZE

[3.] Keywords (i.e., modules, networking, kernel):
kernel, release engineering, drivers

[4.] Kernel version (from /proc/version):
2.4.3

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
N/A
[6.] A small shell script or example program which triggers the
     problem (if possible)
make-kpkg
[7.] Environment
debian, kernel-source-2.4.2 patched up to 2.4.3
[7.1.] Software (add the output of the ver_linux script here)
N/A
[7.2.] Processor information (from /proc/cpuinfo):
N/A
[7.3.] Module information (from /proc/modules):
N/A
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
N/A
[7.5.] PCI information ('lspci -vvv' as root)
N/A
[7.6.] SCSI information (from /proc/scsi/scsi)
N/A
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
N/A
[X.] Other notes, patches, fixes, workarounds:

Doing at least a "christmas tree" build ("all lights on", though in
this case "build *everything* that can be built as a module, and use
the config defaults for the rest" would be quite enough to catch
these) before it goes out the door would be useful...
