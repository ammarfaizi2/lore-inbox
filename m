Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWHXRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWHXRdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHXRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:33:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030421AbWHXRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:33:45 -0400
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1156440438.3418.25.camel@josh-work.beaverton.ibm.com>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433167.3012.119.camel@pmac.infradead.org>
	 <1156440438.3418.25.camel@josh-work.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:33:23 +0100
Message-Id: <1156440803.3012.170.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 10:27 -0700, Josh Triplett wrote:
> Would the generation and use of preprocessed source files ($x.c -> $x.i)
> help solve the "standard CFLAGS" problem here, and allow a subsequent
> single compilation of the entire kernel (sans modules) with --combine
> -fwhole-program?

Not for stuff like CFLAGS_raid6altivec1.o := -maltivec -mabi-altivec

Stuff which is _purely_ #defines, such as...
	ncr53c8xx-flags-$(CONFIG_SCSI_ZALON) \
	                := -DCONFIG_NCR53C8XX_PREFETCH -DSCSI_NCR_BIG_ENDIAN \
	                        -DCONFIG_SCSI_NCR53C8XX_NO_WORD_TRANSFERS
	CFLAGS_ncr53c8xx.o      := $(ncr53c8xx-flags-y) $(ncr53c8xx-flags-m)

... can probably be done differently anyway.

It's not entirely unreasonable to treat files with their own CFLAGS just
as we have to treat .S files -- compile them separately, then link.

-- 
dwmw2

