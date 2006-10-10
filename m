Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWJJQEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWJJQEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWJJQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:04:47 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:8833 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932175AbWJJQEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:04:46 -0400
Subject: [patch 0/2] Introduce round_jiffies() to save spurious wakeups
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 18:02:45 +0200
Message-Id: <1160496165.3000.308.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following 2 patches will introduce the round_jiffies() api and users
thereof. 

The general idea is that by rounding the jiffies for certain timers to
the next whole second will make those timers all happen at the same
time; and thus reduce the number of times the cpu has to wake up to
service timers (this assumes a tickless kernel)

Obviously only timers where the exact time of firing isn't so important
can do this; several of the recurring "always live" timers of the kernel
are of this kind, they want "about once a second" or "about once every 4
seconds" and such, and don't really care about the exact jiffy in which
they fire.

An alternative would have been to introduce mod_timer_rounded() or
somesuch APIs (but there's many variants that take jiffies); I feel that
an explicit caller based rounding actually is quite reasonable.

Greetings,
   Arjan van de Ven
