Return-Path: <linux-kernel-owner+w=401wt.eu-S1754870AbWL1RnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbWL1RnJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbWL1RnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:43:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33243 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbWL1RnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:43:07 -0500
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, olpc-devel@laptop.org
In-Reply-To: <20061228170302.GA4335@dmt>
References: <20061228170302.GA4335@dmt>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 18:43:03 +0100
Message-Id: <1167327784.3281.4341.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 15:03 -0200, Marcelo Tosatti wrote:
> Hi,
> 
> The following patch adds a config option to get rid of the DMA zone on i386.
> 
> Architectures with devices that have no addressing limitations (eg. PPC)
> already work this way.
> 
> This is useful for custom kernel builds where the developer is certain that 
> there are no address limitations.
> 
> For example, the OLPC machine contains:
> 
> - USB devices
> - no floppy
> - no address limited PCI devices
> - no floppy
> 
> A unified zone simplifies VM reclaiming work, and also simplifies OOM
> killer heuristics (no need to deal with OOM on the DMA zone).
> 
> Comments?

Hi,

since one gets random corruption if a user gets this wrong, at least
make things like floppy and all CONFIG_ISA stuff conflict with this
option.... without that your patch feels like a walking time bomb...
(and please include all PCI drivers that only can do 24 bit or 28bit
or .. non-32bit dma as well)

Greetings,
   Arjan van de Ven

