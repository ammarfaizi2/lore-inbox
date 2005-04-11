Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVDKROh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVDKROh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVDKROg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:14:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26361 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261838AbVDKRO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:14:28 -0400
Subject: RT and Signals
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113239666.30549.37.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 10:14:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I'm not sure if this has changed at all in recent RT patches, but I've
noticed several issues popping up that are related to the timer
interrupt sending signals , one in particular is the fact that
send_sig() calls into __cache_alloc() which has it's interrupt disable
protections removed in RT . I've observed slab corruption due to this
while running lmbench and LTP .

	Another issue was a livelock related to the timer interrupt calling
send_sig which locks tasklist_lock and siglock , which are both mutexes
(deadlock detect was on , but didn't trigger).. 

	LTP and lmbench seem to bring all these issues to the surface, but they
are all different depending on the architecture. I've been treating the
symptoms , but not the disease .. Ultimately , we need some protections,
in signal deliver, to stop the timer interrupt .. 

Daniel

