Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVIXTl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVIXTl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVIXTl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:41:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:22022 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750716AbVIXTl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:41:28 -0400
Date: Sat, 24 Sep 2005 21:38:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Willy Tarreau <willy@w.ods.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] fixes for overflow in poll(), epoll(), and msec_to_jiffies()
Message-ID: <20050924193839.GB26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After the discussion around epoll() timeout, I noticed that the functions used
to detect the timeout could themselves overflow for some values of HZ.

So I decided to fix them by defining a macro which represents the maximal
acceptable argument which is guaranteed not to overflow. As an added bonus,
those functions can now be used in poll() and ep_poll() and remove the divide
if HZ == 1000, or replace it with a shift if (1000 % HZ) or (HZ % 1000) is a
power of two.

Patches against 2.6.14-rc2-mm1 sent as replies to this mail.

Regards,
Willy

