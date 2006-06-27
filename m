Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWF0W4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWF0W4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWF0W4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:56:39 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:9960
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161341AbWF0W4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:56:38 -0400
Message-ID: <44A1B79F.9020204@microgate.com>
Date: Tue, 27 Jun 2006 17:56:31 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty_mutex and tty_old_pgrp
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
In-Reply-To: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> In tty_io.c there is a comment that tty_mutex needs to be held before
> changing tty_old_pgrp. If I grep for tty_old_pgrp every place it is
> changed except for one is protected by tty_mutex.
> In security/selinux/hooks.c it appears to be changed without holding
> the lock, is this ok? If it is ok, I can add a comment saying it is.
> 
> If someone were to provide me with the proper guidance, I have some
> time I could spend working on the tty code. For example from an object
> oriented perspective it doesn't look right to me that
> disassociate_ctty is a function in the tty layer. It makes more sense
> to me that this function would be located in the task code.
> 
> How could things be rearranged to avoid the need for sys_setsid() and
> daemonize() to directly manipulate tty_mutex? What exactly is
> tty_mutex protecting, it appears to be used in multiple contexts.

No one has leaped in here with any wisdom, but the people
who wrote that code may be dead or otherwise employed.

If you have knowledge of how those bits work,
I encourage to you dig through the code and determine
what needs to be done. It is certainly an area that can
use more review.

I did see a comment that tty_mutex protects the creation
and destruction of tty structures, so I assume the coverage
of tty_old_pgrp has some relation to that. Unfortunately,
I have seen other locks get borrowed for multiple purposes.

--
Paul


