Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVJOLZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVJOLZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 07:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVJOLZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 07:25:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61841 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751134AbVJOLZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 07:25:07 -0400
Date: Sat, 15 Oct 2005 13:24:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, g4klx@g4klx.demon.co.uk, hch@infradead.org,
       jreuter@yaina.de, paulmck@us.ibm.com, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] rcu in drivers/net/hamradio
Message-ID: <20051015112430.GA3793@electric-eye.fr.zoreil.com>
References: <200510140804.j9E84nwG026920@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510140804.j9E84nwG026920@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> :
[...]
> (3) bpq_free_device() calls list_del_rcu() which, according 
> to list.h, requires synchronize_rcu() which can block or 
> call_rcu() or call_rcu_bh() which cannot block. 
> None of these is called anywhere in the directory drivers/net,
> so synchronize_irq() may address this.  
> (synchronize_sched() is called in drivers/net/sis190.c and 
> r8169.c with FIXME comment about synchronize_irq().)

Same author for both. The code (driver specific) can be issued from
userspace and it needs to wait for running hard_start_xmit to
complete. Afaik synchronize_irq() is not adequate and the FIXME
should go.

--
Ueimor
