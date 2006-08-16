Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWHPRM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWHPRM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHPRMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:12:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750775AbWHPRL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:11:58 -0400
Subject: Re: [PATCH] IB/uverbs: Fix lockdep warning when QP is created with
	2 CQs
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adau04ceim5.fsf@cisco.com>
References: <adau04ceim5.fsf@cisco.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 16 Aug 2006 19:11:23 +0200
Message-Id: <1155748283.3023.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 09:43 -0700, Roland Dreier wrote:
> Arjan, here's a case that disproves your rule of thumb that rwsems
> are equivalent to mutexes as far as correctness goes: you can't have
> an AB-BA deadlock with nested rwsems when using down_read().  In other
> words, the following:
> 
> 	down_read(&lock_1);
> 					down_read(&lock_2);
> 	down_read(&lock_2);
> 					down_read(&lock_1);
> 
> is perfectly safe

it's safe as long as you never ever do a down_write nested inside or
outside a down_read of any of these locks....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

