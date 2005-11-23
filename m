Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVKWJLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVKWJLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 04:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVKWJLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 04:11:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22494 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030380AbVKWJL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 04:11:29 -0500
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org, ak@muc.de
In-Reply-To: <20051123.005530.17893365.davem@davemloft.net>
References: <200511230159.jAN1xeMl003154@hera.kernel.org>
	 <20051123002134.287ff226.akpm@osdl.org>
	 <20051123.005530.17893365.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 10:11:24 +0100
Message-Id: <1132737084.2795.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 00:55 -0800, David S. Miller wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 23 Nov 2005 00:21:34 -0800
> 
> > Nope, this will break !CONFIG_SMP builds.  Quite a few places in the
> > kernel do not implement the ipi handler if !CONFIG_SMP.
> 
> Ho hum, nothing is ever easy eh? :-) I think your patch is fine for
> now, but in the long term the !CONFIG_SMP ifdefs for those ipi
> handlers should probably just get removed.  If GCC can't optimize
> those things away, I'd be really surprised.

it can.. but only if we start using -ffunction-sections in the CFLAGS
(or make all of these functions static I suppose and reenable
-funit-at-a-time, which can be done for gcc 4.x only)

