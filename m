Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269618AbUI3Xa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269618AbUI3Xa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbUI3Xa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:30:59 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:58496 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S269618AbUI3Xar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:30:47 -0400
Date: Fri, 1 Oct 2004 09:30:49 +1000
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: promise controller resource alloc problems with ~2.6.8
Message-ID: <20040930233048.GC7162@zip.com.au>
References: <20040927084550.GA1134@zip.com.au> <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409301615110.2403@ppc970.osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2004 at 04:21:10PM -0700, Linus Torvalds wrote:
> On Mon, 27 Sep 2004, CaT wrote:
> > dmesg does mention it though as:
> > 
> > PDC20267: IDE controller at PCI slot 0000:00:0d.0
> > PCI: Found IRQ 11 for device 0000:00:0d.0
> > PCI: Unable to reserve I/O region #5:40@1080 for device 0000:00:0d.0
> 
> Please send along /proc/ioports for both the working and the non-working 
> version (that's assuming that you can boot far enough in the nw version 
> to get it, of course, but the nw version is actually the more interesting 
> one, so please try ;).

I have the one from 2.6.9-rc2-bk8 available to me (last time I booted I
had time to grab lots of things) so I've attached that and the current
one. If you need the rc3 it'll need to wait another 8 hours or so as I'm
currently away from the PC.

> Also, does the attached patch (written by Shaohua Li based on suggestions 
> by me) solve the problem? My suspicion is that ACPI tables do bad things, 
> and that this might fix it..

Will try when I get home.

-- 
    Red herrings strewn hither and yon.

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports-2.6.8-rc2"

2.6.8-rc2:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:0e.0
  1000-107f : 0000:00:0e.0
1080-10bf : 0000:00:0d.0
  1080-1087 : ide2
  1088-108f : ide3
  1090-10bf : PDC20267
10c0-10cf : 0000:00:14.1
  10c0-10c7 : ide0
  10c8-10cf : ide1
10f0-10f7 : 0000:00:0d.0
  10f0-10f7 : ide2
10f8-10ff : 0000:00:0d.0
  10f8-10ff : ide3
1400-14ff : 0000:00:0f.0
  1400-14ff : tulip
1800-1803 : 0000:00:0d.0
  1802-1802 : ide2
1804-1807 : 0000:00:0d.0
  1806-1806 : ide3
1820-183f : 0000:00:14.2
f800-f83f : 0000:00:14.3
fc00-fc1f : 0000:00:14.3

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports-2.6.9-rc2-bk8"

2.6.9-rc2-bk8:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : 0000:00:0e.0
  1000-107f : 0000:00:0e.0
1080-10bf : 0000:00:0d.0
  10a0-10af : 0000:00:14.1
    10a0-10a7 : ide0
    10a8-10af : ide1
10c0-10df : 0000:00:14.2
10f0-10f7 : 0000:00:0d.0
10f8-10ff : 0000:00:0d.0
1400-14ff : 0000:00:0f.0
  1400-14ff : tulip
1800-1803 : 0000:00:0d.0
1804-1807 : 0000:00:0d.0
f800-f83f : 0000:00:14.3
fc00-fc1f : 0000:00:14.3

--n8g4imXOkfNTN/H1--
