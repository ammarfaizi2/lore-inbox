Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282909AbRK0LNW>; Tue, 27 Nov 2001 06:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282908AbRK0LNM>; Tue, 27 Nov 2001 06:13:12 -0500
Received: from ns.ithnet.com ([217.64.64.10]:51722 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282909AbRK0LM4>;
	Tue, 27 Nov 2001 06:12:56 -0500
Date: Tue, 27 Nov 2001 12:12:28 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Cc: Nicolas.Aspert@epfl.ch, abraham@2d3d.co.za, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
Message-Id: <20011127121228.0df6db46.skraw@ithnet.com>
In-Reply-To: <3C036F83.2000903@dmb.rug.ac.be>
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be>
	<3C022BB4.7080707@epfl.ch>
	<1006808870.817.0.camel@phantasy>
	<3C02BF41.1010303@xs4all.be>
	<20011127101148.C5778@crystal.2d3d.co.za>
	<3C034CAE.2090103@dmb.rug.ac.be>
	<3C036F83.2000903@dmb.rug.ac.be>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 11:48:35 +0100
Didier Moens <Didier.Moens@dmb.rug.ac.be> wrote:

> 2. compared to Stephan's original patches ("if i830m_dev ..." and 
> "break;") :
> 
> Nov 27 11:37:07 localhost kernel: Linux agpgart interface v0.99 (c) Jeff 
> Hartmann
> Nov 27 11:37:07 localhost kernel: agpgart: Maximum main memory to use 
> for agp memory: 439M
> Nov 27 11:37:07 localhost kernel: agpgart: Detected Intel i830M chipset
> Nov 27 11:37:07 localhost kernel: agpgart: AGP aperture is 256M @ 0xd0000000
> 
> [root@localhost agp]# /home/didier/repository/kernel/testgart
> version: 0.99
> bridge id: 0x35758086
> agp_mode: 0x1f000217
> aper_base: 0xd0000000
> aper_size: 256
> pg_total: 112384
> pg_system: 112384
> pg_used: 0
> entry.key : 0
> entry.key : 1
> Allocated 8 megs of GART memory
> MemoryBenchmark: 859 mb/s
> MemoryBenchmark: 887 mb/s
> MemoryBenchmark: 876 mb/s
> Average speed: 874 mb/s
> Testing data integrity (1st pass): passed on first pass.
> Testing data integrity (2nd pass): passed on second pass.

Ok, since performance and detection seems just ok, I would suggest the attached
patch as a fix. Unlike Nicolas I don't see a need for an additional i830MP
patch, its only the correct detection of the different i830 setups that needs
to be done IMHO.
If there are no further complaints we should submit the patch. What do you
think Nicolas?

Regards,
Stephan


--- agpgart_be.c-orig   Tue Nov 27 12:07:14 2001
+++ agpgart_be.c        Tue Nov 27 12:07:02 2001
@@ -3879,6 +3879,10 @@
                        i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                          
PCI_DEVICE_ID_INTEL_830_M_1,
                                                                          
NULL);
+                       /* If we cannot find secondary, we probably have i830MP
+                          which is detected later on */
+                       if (i810_dev == NULL) 
+                               break;
                        if(PCI_FUNC(i810_dev->devfn) != 0) {
                                i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
                                                                               
  PCI_DEVICE_ID_INTEL_830_M_1,
