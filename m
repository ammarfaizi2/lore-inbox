Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277831AbRJLTkx>; Fri, 12 Oct 2001 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277829AbRJLTkn>; Fri, 12 Oct 2001 15:40:43 -0400
Received: from sushi.toad.net ([162.33.130.105]:52963 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277827AbRJLTkj>;
	Fri, 12 Oct 2001 15:40:39 -0400
Subject: Re: kapm-idled Funny in 2.4.10-ac12
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 12 Oct 2001 15:40:24 -0400
Message-Id: <1002915626.10291.67.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just taking a walk through apm.c ...

I notice that set_time() calls get_cmos_time() with interrupts
disabled, whereas get_time_diff calls it with interrupts
enabled.

get_cmos_time is in time.c .  It does a bunch of CMOS_READs
without taking rtc_lock.

Methinks that the
    save_flags(flags); ...; cli(); ...; restore_flags(flags);
constructs in apm.c need some attention.

Thomas

