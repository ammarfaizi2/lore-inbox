Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVHQU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVHQU6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVHQU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:58:40 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38071
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751259AbVHQU6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:58:39 -0400
Subject: [RFC] IPV4 long lasting timer function
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 17 Aug 2005 22:59:01 +0200
Message-Id: <1124312341.23647.277.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while tracking down some timer related ugliness I stumbled over the
timer driven function rt_secret_rebuild(), which does a loop over
rt_has_mask (1024 in my case) entries and possibly some subsequent
variable sized loops inside each step.

On a 300MHZ PPC system this accumulated to a worst case total of >5ms. I
could not reproduce it with this magnitude, but applying heavy
networking load is definitely triggering this behaviour.

Shouldn't this be converted to a workqueue, which gets triggered by a
timer instead of blocking the timer softirq and therefor the delivery of
other timer functions that long ?

tglx




