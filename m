Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVFIQRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVFIQRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVFIQRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:17:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVFIQPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:15:38 -0400
Date: Thu, 9 Jun 2005 09:15:28 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: tcp_bic (was Re: 2.6.12-rc6-mm1 OOPS in tcp_push_one()
Message-ID: <20050609091528.1bc1940e@unknown-215.office.pdx.osdl.net>
In-Reply-To: <200506091523.j59FNmsr008443@turing-police.cc.vt.edu>
References: <200506090423.j594NWts004829@turing-police.cc.vt.edu>
	<20050608.225817.112619139.davem@davemloft.net>
	<200506091523.j59FNmsr008443@turing-police.cc.vt.edu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was all changed in 2.6.12-rc6-tcp1 which is the next version going into
-mm. The default congestion control will be the last one registered (LIFO);
so if you built everything as modules. the default will be reno. If you
build with the default's from Kconfig, bic will be builtin (not a module)
and it will end up the default.

If you really want a particular default value then you will need
to set it with a sysctl.  If you use a sysctl, the module will be autoloaded
if needed and you will get the expected protocol. If you ask for an
unknown congestion method, then the sysctl attempt will fail.

If you remove a tcp congestion control module, then you will get the next
available one. Since reno can not be built as a module, and can not be
deleted, it will always be available.

