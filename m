Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131272AbRCNLYX>; Wed, 14 Mar 2001 06:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRCNLYN>; Wed, 14 Mar 2001 06:24:13 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:27896 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S131272AbRCNLYL>; Wed, 14 Mar 2001 06:24:11 -0500
Date: Wed, 14 Mar 2001 22:23:27 +1100
From: David Luyer <david_luyer@pacific.net.au>
Message-Id: <200103141123.f2EBNRE18969@typhaon.pacific.net.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac20 gets in infinite loop during bootup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to SysRq-P, my system gets in an infinite loop on bootup with
notifier_call_chain calling irda_device_event repeatedly.

This is triggered by toshoboe_open calling register_netdevice.

This is with everything irda-related built-in (I don't like modules); it was
working in 2.4.1-ac8.

Is it possible that the irda_device_event notifier is added twice somewhere?
It appears to me this would result in the observed loop, as if the irda
(priority=0) is on the end of the list and the same notifier is added,
it will position itself at the end of the list again and set it's own 'next'
to a pointer to itself (twice), if I read it correctly.

David.
