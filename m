Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291628AbSBHQQO>; Fri, 8 Feb 2002 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291627AbSBHQQE>; Fri, 8 Feb 2002 11:16:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291628AbSBHQP7>; Fri, 8 Feb 2002 11:15:59 -0500
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
To: davem@redhat.com (David S. Miller)
Date: Fri, 8 Feb 2002 16:26:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davej@suse.de, eike@bilbo.math.uni-mannheim.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020208.074857.88474129.davem@redhat.com> from "David S. Miller" at Feb 08, 2002 07:48:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZDqh-0004AV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    That is incorrect. The warning occurs because someone made bogus changes to
>    the vesa driver without understanding what was going on. The vesa frame
>    buffer returned by the BIOS is a physical cpu address not a bus address
>    and nothing to do with magic PCI mappings.
> 
> There were no changes made, in fact the VESA driver by your own
> definition was buggy before my changes went in. :-) It was using
> bus_to_virt and virt_to_bus all along Alan.

My error then. That or someone broke it around 2.0 8). It should be using
phys_to_virt. Its the usual weirdness of talking to the BIOS which talks in
CPU physical addresses.

VESAfb also genuinely does not know how the frame buffer is wired into the
system, it just has a physical address. Another approach I guess might be
to check if the address range if in a PCI root bridge window and if so 
ioremap it. That possibly also means someone should get around to shrinking
the 1Gb (actually 900M) kernel to 768Mb because some frame buffers are now
at 128Mb of ram
