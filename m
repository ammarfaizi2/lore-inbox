Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136435AbREDPoa>; Fri, 4 May 2001 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136433AbREDPoV>; Fri, 4 May 2001 11:44:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41328 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136435AbREDPoJ>; Fri, 4 May 2001 11:44:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <E14vNsb-0005yf-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 09:41:51 -0600
In-Reply-To: Alan Cox's message of "Thu, 3 May 2001 19:31:04 +0100 (BST)"
Message-ID: <m1hez1nmtc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I suspect it would be safe to round up to the next megabyte, possibly up
> > to 64MB or so. But much more would make me nervous.
> > Any suggestions? 
> 
> I'd go for 1MByte simply because I've not seen an EBDA/NVRAM area that large
> stuck at the top of RAM. 1Mb would fix the Dell. (It was only when I saw
> your email it suddenely clicked and I grabbed the bootup log)

There are a couple of options here.
1) read the MTRRs unless the BIOS is braindead it will set up that area as
   write-back.  At any rate we shouldn't ever try to allocate a pci region
   that is write-back cached.

2) read the memory locations from the northbridge.  It's not possible
   on every chipset (lack of documentation) but with the linuxBIOS
   project we code for a couple of them, and we are working on more
   all of the time.

Eric



