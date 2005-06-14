Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFNOs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFNOs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFNOpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:45:45 -0400
Received: from vtab.com ([62.20.90.195]:23462 "EHLO gorgon.vtab.com")
	by vger.kernel.org with ESMTP id S261155AbVFNOmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:42:22 -0400
Date: Tue, 14 Jun 2005 16:42:20 +0200
Message-Id: <200506141442.j5EEgKJ11377@virtutech.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <mattias@virtutech.se>
To: bernd@firmix.at
Cc: Valdis.Kletnieks@vt.edu, cfriesen@nortel.com, jakub@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dwmw2@infradead.org, drepper@redhat.com
In-reply-to: <1118758583.11557.87.camel@tara.firmix.at> (message from Bernd
	Petrovitsch on Tue, 14 Jun 2005 16:16:23 +0200)
Subject: Re: Add pselect, ppoll system calls.
Content-Type: text/plain; charset=iso-8859-1
References: <200506131938.j5DJcKc10799@virtutech.se>
	 <42ADE52E.1040705@nortel.com> <200506132008.j5DK8t010817@virtutech.se>
	 <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
	 <200506141407.j5EE7sZ11314@virtutech.se> <1118758583.11557.87.camel@tara.firmix.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't have the POSIX specs handy, but I see no reason we could not let
>> it use a warpless monotonic clock.
>
>You have already one - the uptime of the system.

For example, yes. 

>Doing "Relative timeouts" with "gettimeofday()" is a strategic error.
>Specify the timeout und use (the return value of) times(2) for this.

Having an interface use absolute timeouts will avoid this strategic error,
simplify common code, and reduce the number of needed syscalls.

>Use "gettimeofday()" and similar just if (and only if) you communicate
>with the user (read: that is a pure user interface issue).

Of course, but it is not uncommon, perhaps because it's tedious to
convert between clock ticks and a struct timeval.
There is also the problem that the clock tick resolution has historically
been low (commonly 10 ms), which may cause bigger jitter in the longer term.
Also, a clock_t is frequently only 32 bits wide.
