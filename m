Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbRESJJM>; Sat, 19 May 2001 05:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbRESJJC>; Sat, 19 May 2001 05:09:02 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:15620 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S261724AbRESJIx>; Sat, 19 May 2001 05:08:53 -0400
Date: Sat, 19 May 2001 11:07:21 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: VIA's Southbridge bug: Latest (pseudo-)patch
Message-ID: <20010519110721.A1415@pua.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This are the latest suggestions for handling the VIA Southbridge bug as
derived from the hardware site www.au-ja.de (Many thanks to doelf).

Could a linux kernel specialist review and form this pseudo-patch to a real
kernel patch? Given the "old" patch found in 2.4.4 I could have written the
part of setting the PCI registers, but I am totally in the dark as to how to
identify EPOX Mobos and derive their BIOS ID.

Here comes the pseudo-patch:

if( KT133A || KT133 || KX133 ) {
  if( Mainboard=="Epox 8KTA-3(+)" && BIOS>="8kt31417" )
    return 0; /* EPOX already fixed it their way. */
#ifdef NEW_PATCH
  Offset 76: Set bit5=0 and bit4=1 ("every PCI master grand")
#else /* this is already part of 2.4.4 */
  Offset 70: Set bit1=0 ("PCI Delay Transaction = 0")
  Offset 70: Set bit2=0 ("PCI Master Read Caching = 0")
  Offset 75: Set bit0-4 ("0 <=  PCI Latency <= 32")
#endif
}

History (condensed version, more found in [1]):
- When doelf and his colleagues found the Southbridge bug, they already worked
  on a solution, which was adopted by most BIOS updates (but not EPOX) and
  also found its way in 2.4.3-ac7. This patch helped in the majority of the
  buggy boards, but still left some cases unresolved.
- VIA released their own patch ten days ago which tries to solve the Bug
  (viapfd100.exe and the latest 4in1 driver). Not only is this patch only for
  Windows and undocumented, but it also only applies if the running box has a
  Soundblaster card.
- Someone analysed the patch and found the changed PCI settings so that the
  patch could be implemented also for systems without a Soundblaster
  card (see [1]). This is the NEW_PATCH outlined above. This seems to be
  working (all related hardware sites which had discovered the bug are content
  now), so it would be nice to have it in the kernel and test it from within
  linux.

[1] latest english information on the VIA Southbridge bug:
    http://www.au-ja.de/review-kt133a-1-en.html
-- 
Axel.Thimm@physik.fu-berlin.de
