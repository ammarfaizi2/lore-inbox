Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTHZAZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 20:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTHZAZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 20:25:43 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:8625 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262363AbTHZAZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 20:25:42 -0400
Date: Tue, 26 Aug 2003 09:27:45 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030826002745.GA5139@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org> <20030823052633.GA4307@atj.dyndns.org> <20030823122813.0c90e241.skraw@ithnet.com> <20030823151315.GA6781@atj.dyndns.org> <20030823173736.13235adc.skraw@ithnet.com> <20030825063155.GA11458@atj.dyndns.org> <20030825092326.7d360471.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825092326.7d360471.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Stephan,

 I'm sorry but I don't have much idea.  That looks like a deadlock on
io_request_lock, which I think is very unlikely, or maybe another cpu
got io_request_lock and hung.  I've also found out that the bh race I
thought I found didn't exist due to the order of spin_trylock() and
hardirq_trylock() tests in bh_action().  So, only the first
irq_enter() related race is valid.  I've been trying to reproduce your
kernel hang condition with reiserfs and nfs from yesterday without
success.

-- 
tejun
