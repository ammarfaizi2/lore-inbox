Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316575AbSEPFKS>; Thu, 16 May 2002 01:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSEPFKR>; Thu, 16 May 2002 01:10:17 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:5895 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316575AbSEPFKR>;
	Thu, 16 May 2002 01:10:17 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205160510.g4G5AAL28972@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <Pine.LNX.4.44.0205151723390.24102-100000@waste.org> from Oliver
 Xymoron at "May 15, 2002 05:31:31 pm"
To: Oliver Xymoron <oxymoron@waste.org>
Date: Thu, 16 May 2002 07:10:10 +0200 (MET DST)
Cc: "chen, xiangping" <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Oliver Xymoron wrote:"
> On Tue, 14 May 2002, chen, xiangping wrote:
> 
> > But how to avoid system hangs due to running out of memory?
> > Is there a safe guide line? Generally slow is tolerable, but
> > crash is not.
> 
> If the system runs out of memory, it may try to flush pages that are
> queued to your NBD device. That will try to allocate more memory for
> sending packets, which will fail, meaning the VM can never make progress
> freeing pages. Now your box is dead.
> 
> The only way to deal with this is to have a scheme for per-socket memory
> reservations in the network layer and have NBD reserve memory for sending

I entirely agree. However, initial reports are that setting

  current->flags |= PF_MEMALLOC;

in the process about to do the networking (and unsetting it afterwards)
cures the apparant symptoms observed with swap over Enbd (see
freshmeat) in post 2.4.10 kernels.

I'll get back more reports later today.

> and acknowledging packets. NFS and iSCSI also need this, though it's a
> bit harder to tickle for NFS. SCSI has DMA reserved memory for analogous
> reasons.

Ah. I always wondered about NFS. If iSCSI does the reservation in a
controlled way, I will have to look at it.

Peter
