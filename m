Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264272AbRFOIxr>; Fri, 15 Jun 2001 04:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264273AbRFOIxi>; Fri, 15 Jun 2001 04:53:38 -0400
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:30994 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S264272AbRFOIxX>;
	Fri, 15 Jun 2001 04:53:23 -0400
Date: Fri, 15 Jun 2001 11:52:28 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: "David S. Miller" <davem@redhat.com>
cc: James Simmons <jsimmons@transvirtual.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VGA handling was [Re: Going beyond 256 PCI buses]
In-Reply-To: <15145.19442.773217.177804@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21_heb2.09.0106151148580.924-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, David S. Miller wrote:

> James Simmons writes:
>  >  Actually this weekend I'm working on this for the console system. I
>  > plan to get my TNT card and 3Dfx card both working at the same time both in
>  > VGA text mode. If you also really want to get multiple card in vga text
>  > mode it is going to get far more complex in a multihead besides the
>  > problem of multiple buses.
> 
> You going to have to enable/disable I/O, MEM access, and VGA pallette
> snooping in the PCI_COMMAND register of both boards every time you go
> from rendering text on one to rendering text on the other.If there
> are bridges leading to either device, you may need to fiddle with VGA
> forwarding during each switch as well.
> 
> You'll also need a semaphore or similar to control this "active VGA"
> state.

Why do that? You ignore the vga regions of all the cards except for the
primary, and program all other cards by accessing their PCI mapped
regions, which are programmed not to overlap, so they are completely
independent.
This is what nvvgacon does for using text mode of secondary nvidia card. 

-- 
Matan Ziv-Av.                         matan@svgalib.org


