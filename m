Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTFFJZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTFFJZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:25:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265161AbTFFJZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:25:17 -0400
Date: Fri, 06 Jun 2003 02:36:18 -0700 (PDT)
Message-Id: <20030606.023618.13768006.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306051530.h55FUYsG014279@ginger.cmf.nrl.navy.mil>
References: <200306051530.h55FUYsG014279@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Thu, 05 Jun 2003 11:28:47 -0400

   thanks to someone for pointing out to me my flub when i errantly
   converted a spin_unlock to rtnl_lock (it in a very rarely, never
   in fact as far as i know, used section of the code.  this following
   should now be even more correct.
   
   [ATM]: use rtnl_{lock,unlock} during device operations
   
Are you sure nothing needs to walk the list in interrupt or softint
context?  That's why you can't normally protect all of it using the
RTNL semaphore, because walks occur in non-sleepable contexts.

Read the comment above dev_base in drivers/net/Space.c to see what
the intended locking model is.
