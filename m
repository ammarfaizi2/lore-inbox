Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317899AbSGLATI>; Thu, 11 Jul 2002 20:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSGLATH>; Thu, 11 Jul 2002 20:19:07 -0400
Received: from fe5.southeast.rr.com ([24.93.67.52]:54538 "EHLO mail5.nc.rr.com")
	by vger.kernel.org with ESMTP id <S317899AbSGLATG>;
	Thu, 11 Jul 2002 20:19:06 -0400
Message-ID: <3D2E215A.9010200@nc.rr.com>
Date: Thu, 11 Jul 2002 20:22:50 -0400
From: Greg Smith <gsmith@nc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fsync and ftruncate weirdness
References: <3D2E0FD7.6020802@nc.rr.com>
Content-Type: multipart/mixed;
 boundary="------------020300020106000507050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300020106000507050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox suggested that I forward this message here and attach the
testcase.  For clarification, `hercules' is an ibm mainframe emulator
-- yes, I know how that sounds, but ac himself has been rumoured to
use it.  Warning, if you are able to recreate the error using the
testcase then you may have to reboot.  I have only recreated the
problem on ia32.

Symptom is *very* slow response time for ftruncate() after fsync()
and ftruncate() have already been issued previously for the file,
if the file is large (hundreds or thousands of megabytes).

Many thanks,

Greg Smith

Greg Smith wrote:
> Hi Alan.  I got your email address from the linux-vm list on Marist.
> I'm also a developer for hercules, mostly doing the compressed disk
> emulation, but also other stuff (eg the linux-390 i/o problem).
> 
> I've run into a problem and don't know where to turn with it,
> so maybe you can give me some advice.
> 
> In the next release of hercules (2.17) we will do a fsync every
> 5 seconds (by default) for an emulated disk image.  Code has been
> added to not write to space that has been freed since the last
> fsync.  If some catastrophic error occurs, then we should be able
> to recover the disk image up to at least the time of the last fsync.
> 
> The size of an emulated disk image changes over time.  When
> free space is moved by the garbage collector to the end of the file,
> we issue ftruncate to decrease the file size.  Since the fsync was
> added, I have noticed that a slower machine (piii650 768M)  will go
> into a loop in kernel space lasting *hours*.  Oh, the file in this
> circumstance is large, exceeding 600M.
> 
> Using `oprofile' (http://oprofile.sourceforge.net/index.php3), I
> have determined that all the cpu time is spent in mm/filemap.c
> routine truncate_list_pages which is called by truncate_inode_pages.
> The linux kernel is 2.4.18.  The linux system is responsive, but
> the hercules process is hosed.  The last system call by hercules
> is ftruncate.  I am using ext3 fs; I mean to test on ext2 but
> haven't gotten to it yet.
> 
> If I remove either the fsync or the ftruncate, then the loop does
> not occur.  As a workaround, I am only issuing ftruncate if there's
> at least a M to truncate, and then I close the file and open it
> again before doing it.  Ugly, but beats the alternative.
> 
> Attached is a program that I was able to recreate the problem
> on my slower machine (./ftest test 800).
> 
> Thanks for your time,
> 
> Greg Smith



--------------020300020106000507050609
Content-Type: application/x-gzip;
 name="ftest.c.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ftest.c.gz"

H4sICIj0LT0AA2Z0ZXN0LmMAdVNtS+NAEP6c/IqhouzW2KYt7R2kCqL9cJwv0CoKXglpstHl
kk3Jbk7U+t9vZhPti7iQ7OaZmWdmnp102yCzrNKmjIyAZVksMpFDpaV6hFS/qJhxOIDUlJWK
0YNxF+zqdFMjtIFUZkJFuQAtXwUAs5vUoKp8IUq45Ojb7rp7UsVZlQgYa5NkctF5OtnEXnTX
vCyF/gprE5ltNI2VyXYcTSKLbahSEtFtzMhcEOLuJSKVSkAZqaTImeLAmFSGM4bndq/jt8nC
OO+y6enVeXh5ek8o59x10Q/ySCqgCIjKx9iD+CkqoY3nfw9z7r45ZJFemnj6NXAd1LaKDVAn
+EKA6gjxjOp6qnhGxBIsqvRhNBwORvPAdR2ZAiN2GMMAVitU9hWOITKFZDZRf845jI/B567j
lMJUpYKjHkWmCToWS6Fqx97cuw6n53fT1XV4Np2c3uA+uT+78Gbhr+ntbLrC/Q53HtRJMXyM
rPCGvEtRlkXJWsTWIofNTM47JUOzxHx+ABLjbP14PDyksqgjOUdrI3R/OOLB16BBH9qAUn2E
PZcSJw3lgwNiaIIH/R+jn3zuQX0gHlIQaVBDfJOq7Or24oLqXJZ4Bylr0XjCx0zuJ5coIOzr
P6qFV+PFNuQAwznFYFWwVVZQi5DSzdXlaGNFyLQQf8FCrEjT0PCmRm062oSU76iu0oPZZPI7
nE1ubCDp27j2OLWKekaJJcJO1605jsAcZF9rseNAVNT4ybEdJDiEYV3uuneL09rXrd1mqS0y
I3X9WZsJq78/WT5+/U0W69bQfNptlWsF4Gij2m/p4yJfZgKjm2vZSQDfLJwUonnHp9KZEEvW
833fUq/7tCPqxFmhRdNmM71+4L67/wHlHwM/+gQAAA==
--------------020300020106000507050609--

