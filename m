Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSGDN1M>; Thu, 4 Jul 2002 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317407AbSGDN1L>; Thu, 4 Jul 2002 09:27:11 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:52749 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317406AbSGDN1K>; Thu, 4 Jul 2002 09:27:10 -0400
Date: Thu, 4 Jul 2002 14:29:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 IDE 97
Message-ID: <20020704142938.D11601@flint.arm.linux.org.uk>
References: <Pine.SOL.4.30.0207030021060.27685-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.30.0207030021060.27685-200000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Wed, Jul 03, 2002 at 12:22:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 12:22:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> This patch is a accumulation of ata-hosts-7/8/9/10/11, ata-autodma
> and ata-ata66_check patches previously posted on LKML.

>From a first review only, it looks like this patch prevents the chipset
drivers from disabling DMA mode on initialisation.  This is Really Bad(tm)
since some revisions of some chipsets must _never_ be placed into DMA
mode due to hardware bugs.  Even if the user selects CONFIG_IDEDMA_AUTO.

The code in sl82c105.c knows about the chipset revisions that this is
required for, and it looks like the code in ide-pci.c will override the
chipset if CONFIG_IDEDMA_AUTO is enabled.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

