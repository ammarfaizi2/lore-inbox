Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUJZC5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUJZC5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUJZC5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:57:00 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12268 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262101AbUJZCr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:47:29 -0400
Subject: Fixing MTRR smp breakage and suspending sysdevs.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098758354.4120.7.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Oct 2004 12:39:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've just had a go at fixing the issue with my implementation not
suspending the sysdevs (I believe swsusp does the same). In the process,
I reworked the MTRR support so it's not treated as a sysdev. Instead,
when we're saving cpu state, the mtrr_save function function is called.
When we go to restore CPU state, each CPU calls a function that resets
it's MTRRs and the 'main' cpu then frees the saved data. This is working
well here (did a dozen plus suspends on the trot), but I want to check
that it sounds like the right solution to you.

Perhaps this method should be made more generic? (Are there likely to be
other per-cpu state savers needed?)

One thing I have noticed is that by adding the sysdev suspend/resume
calls, I've gained a few seconds delay. I'll see if I can track down the
cause.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

