Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUH3R41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUH3R41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUH3Rwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:52:50 -0400
Received: from pD9E73D60.dip.t-dialin.net ([217.231.61.96]:55941 "EHLO
	abc.local") by vger.kernel.org with ESMTP id S268723AbUH3RvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:51:02 -0400
Date: Mon, 30 Aug 2004 19:52:15 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Jacek Pop?awski <jacekpoplawski@wp.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc1 stv0299 fix
Message-ID: <20040830175215.GA15303@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Jacek Pop?awski <jacekpoplawski@wp.pl>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040830075244.GA166@bokowka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830075244.GA166@bokowka>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 07:52:44AM +0000, Jacek Pop?awski wrote:
> 
> I use SkyStar 2.6c DVB card. I noticed that I can't watch digital television
> anymore, after 2.6.7 to 2.6.9-rc1 upgrade. First reason was change of DVB
> device, but second one is little bug in kernel.
> 
> Name of device has been changed in 2.6.9-rc1 to "SkyStar2", but module stv0299
> still compares name with "Technisat SkyStar2 driver", strings are different,
> and result is that stv0299 detects invalid tuner type. Not only I am not able
> to tune anything, but also I can crash system just by reloading DVB modules and
> being in X at same time.

How so? What does the DVB driver have to do with X?

> Following obvious patch fixes problem.

Patch looks good. Please apply.

Johannes


--- linux-2.6.9-rc1/drivers/media/dvb/frontends/stv0299.c	2004-08-25 21:40:56.000000000 +0200
+++ linux/drivers/media/dvb/frontends/stv0299.c	2004-08-30 02:08:00.902739808 +0200
@@ -1271,7 +1271,7 @@
 
 	printk ("%s: try to attach to %s\n", __FUNCTION__, adapter->name);
 
-	if ( strcmp(adapter->name, "Technisat SkyStar2 driver") == 0 )
+	if ( strcmp(adapter->name, "SkyStar2") == 0 )
 	{
 	    printk ("%s: setup for tuner Samsung TBMU24112IMB\n", __FILE__)


