Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbVKBKyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbVKBKyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbVKBKyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:54:08 -0500
Received: from styx.suse.cz ([82.119.242.94]:59608 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751568AbVKBKyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:54:06 -0500
Date: Wed, 2 Nov 2005 11:54:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Percpu data in a vsyscall page
Message-ID: <20051102105405.GA5320@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on a RDTSCP support on x86-64, and for that, I'll need
per-cpu time offset table in a vsyscall page. I saw the percpu.h header,
and thought - "Hey, I could use that!", but I think I really can't.

The data need to be in a vsyscall page, which is mapped to userspace via
linker magic, and the percpu stuff uses a different mapping.

I'm using a simple array instead, because the address will be different
in a vsyscall from the one the kernel sees anyway, and RDTSCP will give
me an index to that array atomically.

Is there any problem with that approach? Is there any reason using
percpu.h would be better? 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
