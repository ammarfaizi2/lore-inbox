Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSEGMyt>; Tue, 7 May 2002 08:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSEGMys>; Tue, 7 May 2002 08:54:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:35802 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315438AbSEGMyj>;
	Tue, 7 May 2002 08:54:39 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15575.52723.240506.668782@argo.ozlabs.ibm.com>
Date: Tue, 7 May 2002 22:52:03 +1000 (EST)
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.13 IDE 54
In-Reply-To: <3CD5564A.6030308@evision-ventures.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:

> Sun May  5 16:32:22 CEST 2002 ide-clean-54
> 
> - Finish the changes from patch 53. ide_dma_actaion_t is gone now as well as
>    whole hidden code paths associated with it. I hope I didn't mess too many
>    things up with this, since the sheer size of the changes make them sensitive.

I'm wondering how you would suggest that I change ide-pmac.c now so
that it compiles and works again.

With this patch we have calls to udma_enable scattered throughout
ide.c, and udma_enable assumes that it is to do its stuff by poking
particular I/O ports.  You seem to have taken away the ability to have
a chipset provide its own methods for setting up, enabling and
disabling DMA.

The comment above udma_enable seems to indicate that you think it
should be ifdef'd per-architecture.  That won't work for us (besides
being ugly), because we can have two ATA host adaptors in the one
machine that need to be programmed quite differently.  Consider for
instance a powermac with the built-in IDE interface (which would use
the ide-pmac.c code) and a plug-in PCI IDE card, for which the
udma_enable code is presumably correct.

So we definitely need to have the DMA setup/enable/disable methods
able to be specified per host adaptor.

If I have missed something, please let me know.  But it looks to me
very much as though this patch makes it impossible for me to use my
powermac IDE interfaces.

Paul.
