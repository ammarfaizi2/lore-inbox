Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSEPFTu>; Thu, 16 May 2002 01:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316581AbSEPFTt>; Thu, 16 May 2002 01:19:49 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:51719 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316580AbSEPFTt>;
	Thu, 16 May 2002 01:19:49 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205160519.g4G5JhL29381@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <200205160510.g4G5AAL28972@oboe.it.uc3m.es> from "Peter T. Breuer"
 at "May 16, 2002 07:10:10 am"
To: ptb@it.uc3m.es
Date: Thu, 16 May 2002 07:19:43 +0200 (MET DST)
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "chen, xiangping" <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver Xymoron wrote:"
> If the system runs out of memory, it may try to flush pages that are
> queued to your NBD device. That will try to allocate more memory for
> sending packets, which will fail, meaning the VM can never make progress
> freeing pages. Now your box is dead.

The system can avoid this by

 a) not flushing sync  (i.e. giving up on pages that won't flush immediately)
 b) being nondeterministic about it .. not always retrying the same
    thing again and again.

Can one achieve those characteristics? I suspect setting the vm
sync boundary to 100% should arrange for (a)?

Peter
