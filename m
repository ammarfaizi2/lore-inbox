Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbRLHU5a>; Sat, 8 Dec 2001 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285936AbRLHU5V>; Sat, 8 Dec 2001 15:57:21 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:44817 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285935AbRLHU5H>; Sat, 8 Dec 2001 15:57:07 -0500
Date: Fri, 7 Dec 2001 22:01:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-ram on athlons
Message-ID: <20011207220130.A9253@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

suspend-to-ram was not working on athlons... Now I found the reason...

We wrote some data to memory, and then told hw to powerdown everything
but memory.

But somehow data were not in memory.

So I added mdelay(1000) and printk().

Data were still not in memory.

So I added wbinvd().

Yep, that helped. That means that athlons happily write-back-cache
data for 1 second.... Ouch.

Okay, I just did not expect *that* kind of trick being played at me.

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
