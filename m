Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCZIc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCZIc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVCZIc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:32:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261924AbVCZIcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:32:47 -0500
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -
	fs/ext2/
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 09:32:38 +0100
Message-Id: <1111825958.6293.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 17:29 -0500, linux-os wrote:
> Isn't it expensive of CPU time to call kfree() even though the
> pointer may have already been freed? 

nope

a call instruction is effectively half a cycle or less, the branch
predictor of the cpu can predict perfectly where the next instruction is
from. The extra if() you do in front is a different matter, that can
easily cost 100 cycles+. (And those are redundant cycles because kfree
will do the if again anyway). So what you propose is to spend 100+
cycles to save half a cycle. Not a good tradeoff ;)

