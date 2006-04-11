Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWDKIC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWDKIC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDKIC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:02:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21684
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932340AbWDKIC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:02:57 -0400
Date: Tue, 11 Apr 2006 01:02:43 -0700 (PDT)
Message-Id: <20060411.010243.132136674.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: dave@thedillows.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604111028.54813.vda@ilport.com.ua>
References: <200604101716.58463.vda@ilport.com.ua>
	<1144682807.12177.22.camel@dillow.idleaire.com>
	<200604111028.54813.vda@ilport.com.ua>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Tue, 11 Apr 2006 10:28:54 +0300

> But it saves some text (~5k total in all network drivers)
> and removes a branch on rx path on non-VLAN enabled kernels...

It removes "5K total" when you build every single networking driver
statically into the main kernel image.

Nobody does that except for build sanity testing.  Folks will
enable the drivers they need for their testing into a static
kernel, or build all the net drivers they want modular.

Please resist the urge to work on things like this in a robotic
fashion.  Consider whether the thing you're working on really matters
in real life, and whether the alternative you're providing is really
an overall improvement.  In this case you're "improving" a case only
kernel build testers will use, and the amount of ifdef's added by
your patches uglify the code immensely.  To me, that's a clear net
loss.
