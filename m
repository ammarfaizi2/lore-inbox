Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCVPro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUCVPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:47:44 -0500
Received: from [193.192.238.141] ([193.192.238.141]:35601 "EHLO
	dupond.visiowave.com") by vger.kernel.org with ESMTP
	id S262071AbUCVPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:47:41 -0500
From: "Marc de la Gueronniere" <marcdlg@visiowave.com>
To: <linux-kernel@vger.kernel.org>
Subject: udp bind & udp_port_rover behavior
Date: Mon, 22 Mar 2004 16:47:38 +0100
Message-ID: <00a801c41025$00fb4c80$7e06010a@visiowave.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I came across strange problems while porting an udp-based application.
These problems originated from very weak assumptions (no source ip/port
checking, no stream ID,...) in this application. These weaknesses are
exposed by the behavior of the udp_port_rover/udp_v4_get_port mechanism
i.e. udp_port_rover is not incremented after allocation which can cause
the immediate reallocation of a port that was just freed causing
potentially the reception of packets that were not meant for the
application opening the new port. While there is no doubt in my mind
that the application is clearly at fault, incrementing the rover feels
like a safer behavior. If a port is immediately reused this will cause:
-ICMP port unreachable message to not be sent, while the old receiving
end has died.
-any UDP applications not doing source checking to likely receive random
packets, triggering weird bugs that did not happen on other platforms.

Marc

PS: please CC me directly as I am not currently subscribed to the list.

