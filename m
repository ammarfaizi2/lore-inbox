Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUCDLtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUCDLtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:49:17 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:27271 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261846AbUCDLtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:49:14 -0500
MIME-Version: 1.0
Date: Thu,  4 Mar 2004 12:48:49 +0100
To: linux-kernel@vger.kernel.org
X-UMS: email
X-Mailer: TOI Kommunikationscenter V3-0-4
Subject: Bugreport Kernel 2.6.3 agpgart intel_agp i810 i810fb insmod depmod
From: RG.Schneider@t-online.de
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1AyrLN-1MHlR20@filter05.bbul.t-online.de.18.172.in-addr.arpa>
X-Seen: false
X-ID: VsYZIMZpwevkYLoA6ZRe6koIB3FJU4Vvh1aIAjScZzqAAKCobv9QE4@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I don't really know where to send this problem/bug report other than to
the main entrance. I have put most
keywords into the header to make it easier to address the correct
people.
Thanks for your patience.

When I compiled/booted a kernel 2.6.3 and found the following problems:

1. I'm working with a HP e-Vectra PC wich uses a Intel i810 chipset for
sound an graphics. ( I810E ).
   When the X-server is requesting the "i810.ko"
(~kernel/drivers/char/[agp|drm]) kernel module, it 
   fails to initialize. After looking around a little bit, I found out
that the agppart module has 
   been splitted into a generic one and many chipset/graphic cards
specific ones. 
   On this machine the "agpgart.ko" is loaded but not the neccessary
"intel_agp.ko". After manually inserting
   "intel_agp.ko" it was possible to load "i810.ko" to and X could start
also without problems.
   Looking ( and re-executing depmod ) into modules.dep, there was no
dependency between "i810.ko" and 
   "intel_agp.ko"

   According to the man pages of depmod, it can detect such dependencies
between modules only if symbols are
   correlated ( exported/imported ) between modules. 

   So my question is: is this a bug or wanted/neccessary to have
"i810.ko" not depending on "intel_agp"?
   A similar question is about the two frame buffer mod

2. After loading "intel_agp.ko" -> "i810.ko" or "i810fb.ko" and
unloading "i810.ko" / "i810fb.ko", it was not possible
   to unload "intel_agp.ko". rmmod ( and lsmod, too ) persisted to state
that "intel_agp.ko" is still in use.

   After reboot of the machine and no "intel_agp.ko" in the memory
again, I loaded it again and saw that it immidiately
   is used - as it looks like by the "agpgart.ko". I'll write down the
screen output::
           
	     # modprobe intel_agp
	     agpgart: Detected an Intel i810 E chipset
	     agpgart: Maximum main memory to use for agp memory: 93M
	     agpgart: AGP aperture is 64M @ 0xe8000000
	     # lsmod
	     module      size       used by
	     intel_agp   16981      1
	     agpgart     28332      1 intel_agp
	     .
	     . (more modules)
   
   It seems that "agpgart" becomes aware of the chipset/graphics
controller and starts an initialisation process.
   The "intel_agp" or the kernel ? is aware of this 'usage' of
"intel_agp" by "agpgart" and "intel_agp" is 'in use'
   now.
   Because of this cross usage, it is no longer possible to unload
"intel_agp.ko" and / or "qagpgart" - at least 
   not without brute force. 
   Question: Is this behavior wanted?

3. I recognized that insmod doesn't know the path to the modules
anymore. Other than modprobe, one has to be in the
   corresponding directory where the kernel module is located or have to
give the full path as:
            
	     # insmod /lib/modules/2.6.3/kernel/char/drm/i810.ko

   The version of insmod is 2.4.21 ( shipped with the "Knoppix CT'
edition 3.4" CD from Feb2004 ). 
   CT' is a german computer magazine.

   Sorry, I havn't been looking for a newer version yet. So it might be
obsolete already.


 Thanks again for your patience 


 /RalfS

 




