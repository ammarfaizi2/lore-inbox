Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTIONvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTIONvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:51:01 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:62114 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261193AbTIONum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:50:42 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030915080336.19165D-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030915080336.19165D-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063633696.2674.20.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 14:48:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 13:11, Bill Davidsen wrote:
> The code to disable prefetch on Athlon is 300 bytes and hurts your PIV?
> Really? I'll dig back through the code, but I recall it as adding or
> deleting an entry in a table to enable prefetch. If it's affecting PIV the
> code to use prefetch is seriously broken.

Big time. Its over 300 bytes long because its embedded in each inline
prefetch and it causes a branch misprediction almost every time. Amazing
what you find when you actually measure stuff 8)

So right now, its faster on PIV to delete the prefetch than use the
current hack, and adding the Athlon fix makes Athlon and PIV faster and
total memory size lower.


