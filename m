Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVL1TfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVL1TfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVL1TfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:35:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964890AbVL1TfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:35:00 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
In-Reply-To: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 20:34:54 +0100
Message-Id: <1135798495.2935.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The forced inlining is not just a good idea. Several versions of gcc would 
> NOT COMPILE the kernel without it.

yup that's why the patch only does it for gcc4, in which the inlining
heuristics finally got rewritten to something that seems to resemble
sanity...

> Also, the inlining patch apparently makes code larger in some cases, so 
> it's not even a unconditional win.

.... as long as you give the inlining algorithm enough information.
-fno-unit-at-a-time prevents gcc from having the information, and the
decisions it makes are then less optimal... 

(unit-at-a-time allows gcc to look at the entire .c file, eg things like
number of callers etc etc, disabling that tells gcc to do the .c file as
single pass top-to-bottom only)



