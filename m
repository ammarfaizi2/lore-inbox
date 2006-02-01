Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWBALvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWBALvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBALvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:51:37 -0500
Received: from mail.suse.de ([195.135.220.2]:32940 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751126AbWBALvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:51:36 -0500
Date: Wed, 1 Feb 2006 12:51:34 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ISDN warning
Message-ID: <20060201115134.GA8219@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20060201010406.05f55c09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201010406.05f55c09.akpm@osdl.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 01:04:06AM -0800, Andrew Morton wrote:
> 
> Karsten, could you please take a look at fixing this?
> 
> drivers/isdn/hisax/hscx_irq.c: In function `hscx_interrupt':
> drivers/isdn/hisax/hscx_irq.c:201: warning: comparison is always 1 due to width of bit-field
> 
> It's due to
> 
> 	(PACKET_NOACK != bcs->tx_skb->pkt_type)
> 
> pkt_type is only three bit wide.
> 

I think this should fix it for the moment, pkt_type 7 is not used yet and
this is only used internal in hisax.

Signed-off-by:  Karsten keil <kkeil@suse.de>

diff -ur a/drivers/isdn/hisax/hisax.h b/drivers/isdn/hisax/hisax.h
--- a/drivers/isdn/hisax/hisax.h	2005-08-29 01:41:01.000000000 +0200
+++ b/drivers/isdn/hisax/hisax.h	2006-02-01 12:39:21.000000000 +0100
@@ -217,7 +217,7 @@
 #define GROUP_TEI	127
 #define TEI_SAPI	63
 #define CTRL_SAPI	0
-#define PACKET_NOACK	250
+#define PACKET_NOACK	7
 
 /* Layer2 Flags */
 

-- 
Karsten Keil
SuSE Labs
ISDN development
