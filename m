Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154420AbPFGMBt>; Mon, 7 Jun 1999 08:01:49 -0400
Received: by vger.rutgers.edu id <S154326AbPFGMBi>; Mon, 7 Jun 1999 08:01:38 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:4516 "EHLO zikova.cvut.cz") by vger.rutgers.edu with ESMTP id <S154441AbPFGL7N>; Mon, 7 Jun 1999 07:59:13 -0400
From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: mj@ucw.cz
Date: Mon, 7 Jun 1999 13:58:52 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [RFC] new bus architecture (+ byte-endianess)
CC: linux-kernel@vger.rutgers.edu
X-mailer: Pegasus Mail v3.40
Message-ID: <972F6C62379@vcnet.vc.cvut.cz>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi Martin,
  I read your specification and it looks good, except that
(1) in proc filesystem, you (probably due to mistake) used
   pci0/xx.x/...
   pci1/xx.x/...
   usb0/xx.x/...
  Isn't it better to use pci/0/..., pci/1/... ?
  I also did not understand, if pci0/07.0/x.xx are devices on
bridge 7.0 on bus pci0, how is accessible bridge itself? As some
file in 07.0 subdirectory?
(2) will you offer some bus_to_bus address translation functions, for
  example for supporting DMA from one (PCI) bus to another on PowerPC
  (PowerPC uses translating bridge)?
(3) do not forget about architectures which maps regular I/O into
  memory address space - we should have ioremap_io() and inl/outl (_le?) -
  on ia32, ioremap_io = nothing, inl/outl are I/O operations, on
  PreP PPC, ioremap_io = return io+0x80000000; and inl/outl are synonyms
  for readl/writel...

  And for byte endianess in readl/writel - if you'll say that on every
architecture readl/writel will store long in little endian, we can
live with it - but I do not know why. If processors supports storing
data with both endianess, why not to export this functionality to kernel
drivers? I can understand that ia32 peoples complaints about supporting
readl_be on their hardware, but PPC can do both be and le accesses very
easy...
  If some ports have problem with it (specific iomapping and universal
load/store), then we can create complete set with both ioremap_[lb]e,
{read,write}[wl]_[bl]e. If there is some functionality hidden from
users, programmers get around with ugly hacks... Isn't it easier to
open the doors?
  For example matroxfb have to be compatible with old XF86_SVGA on PPC
(do not have, but it is better if it cost almost nothing...). And XF86_SVGA
on PPC switched matrox into big endian mode... So have I to byteswap
all pixels and commands written to hardware and then store these data
to hardware using little-endian store? Why? Or should I break backward
compatibility for no real reason? I do not want to do that.
                                That's all (for now),
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
