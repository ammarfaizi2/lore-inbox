Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWIKQLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWIKQLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWIKQLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:11:00 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:8976 "EHLO MMS3.broadcom.com")
	by vger.kernel.org with ESMTP id S932231AbWIKQK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:10:59 -0400
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Subject: Re: TG3 data corruption (TSO ?)
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: "Segher Boessenkool" <segher@kernel.crashing.org>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1157953925.31071.413.camel@localhost.localdomain>
References: <1551EAE59135BE47B544934E30FC4FC093FB2C@NT-IRVA-0751.brcm.ad.broadcom.com>
 <1157953925.31071.413.camel@localhost.localdomain>
Date: Mon, 11 Sep 2006 09:08:51 -0700
Message-ID: <1157990931.5436.5.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: TS=20060911161052; SEV=2.0.2; DFV=A2006091105;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230322E34353035383845362E303034412D422D306A7671374D75736C6841666147687761704E7344673D3D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006091105_4.00.0004_4.0-8
X-WSS-ID: 691B5502230555559-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 15:52 +1000, Benjamin Herrenschmidt wrote:

> Looks like adding a sync to writel does fix it though... I'm trying to
> figure out which specific writel in the driver makes a difference. I'll
> then look into slicing those tcpdumps.

During runtime in the fast path, the only writel()'s we do in tg3 are to
the tx mbox, rx_mbox, and the interrupt mbox.  The interrupt mbox
shouldn't matter that much since it has no dependencies on other memory
writes before it.

