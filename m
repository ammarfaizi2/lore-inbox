Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVJFNTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVJFNTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVJFNTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:19:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63674 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750897AbVJFNTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:19:16 -0400
Subject: Re: SMP syncronization on AMD processors (broken?)
From: Arjan van de Ven <arjan@infradead.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       Andrey Savochkin <saw@sawoct.com>, st@sw.ru
In-Reply-To: <434520FF.8050100@sw.ru>
References: <434520FF.8050100@sw.ru>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 15:19:07 +0200
Message-Id: <1128604748.2960.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 17:05 +0400, Kirill Korotaev wrote:
> Hello Linus, Andrew and others,
> 
> Please help with a not simple question about spin_lock/spin_unlock on 
> SMP archs. The question is whether concurrent spin_lock()'s should 
> acquire it in more or less "fair" fashinon or one of CPUs can starve any 
> arbitrary time while others do reacquire it in a loop.

spinlocks are designed to not be fair. or rather are allowed to not be.
If you want them to be fair on x86 you need at minimum to put a
cpu_relax() in your busy loop...


