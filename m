Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVKUU4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVKUU4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVKUU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:56:34 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:29035 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751052AbVKUU4d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:56:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RyHVVMVEHbzdzEhS7HvRR1t6Clh6c2nF3wrdQtJQkc1GfwXc8bXabPOzndhgzjomTePcaBUOav5iatrV0oTbjGnQGN6WuGH47HTCzH0UH9nicA2BklR4/NY05BVWSvszw49povITKKMd5ZcLlzlyC4psSBo3p5U5cMYiTui9AsQ=
Message-ID: <7d40d7190511211256o479d1393r@mail.gmail.com>
Date: Mon, 21 Nov 2005 21:56:32 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: disabling NAPI poll
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

What I need is to turn off and on the polling done to a network device
which works with NAPI. I'll explain: the network driver issues
netif_rx_schedule() and inserts itself in that cpu's poll_list. But,
transparently, in higher-layer kernel code, that device could be
extracted from that poll_list (if the machine is in congestion, that's
the research i'm doing) and added again later.

To do that, I guess I could just remove the device from the poll_list
and add it again when needed, but then the cpu in which I'm doing this
could be different from the previous (if in SMP context), right?
Anyway, if this is what I have to do, I could just access
per_cpu(softnet_data, cpu), but I guess a lock is required for that
(because I am accessing the info for another cpu). In that case, what
lock?

I've looking if there is any function for that purpose, and found
netif_poll_enable/disable, but I couln't find any information that
explains what it is for and the purpose of the bit
__LINK_STATE_RX_SCHED. Anyone can tell?

Thank you.
Regards

Aritz
