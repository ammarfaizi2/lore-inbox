Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUFEMP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUFEMP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 08:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUFEMP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 08:15:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:62174 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261206AbUFEMPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 08:15:37 -0400
Date: Sat, 5 Jun 2004 14:15:04 +0200 (MEST)
Message-Id: <200406051215.i55CF4hH004189@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jgarzik@pobox.com
Subject: Re: PROBLEM: network driver causes kernel panic
Cc: dctucker@hotmail.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2004 16:47:13 -0400, Jeff Garzik wrote:
>Mikael Pettersson wrote:
>> This confirms that eth1 is a 21041 driven by the de2104x driver.
>> 
>> I've seen something very similar to Casey's problem, on a PowerMac
>> with a built-in 21041. Booting it with no network cable connected
>> causes a timer to hit a BUG() in de2104x about a second after
>> the device is ifup:d.
>> 
>> The 2.4 kernel's tulip driver works just fine.
>> 
>> I reported this last year, but nothing happened.
>
>
>Well, I'm very interested in debugging it.  There were a flurry of 
>de2104x patches in the past year, I thought that took care of the issues.
>
>Please email details to netdev@oss.sgi.com and jgarzik@pobox.com...

Booting 2.6.7-rc1 with the de2104x driver built-in and eth0
disconnected from the LAN leads to the following oops about
a second after INIT tried to ifup eth0:

eth0: timeout expired stopping DMA
kernel BUG in de_set_media at drivers/net/tulip/de2104x.c:919!
<register dump omitted>
Call trace:
de21041_media_timer
run_timer_softirq
__do_softirq
do_softirq
timer_interrupt
ret_from_except
ppc6xx_idle
cpu_idle
rest_init
start_kernel

The PowerPC kernel decides to panic() after a brief delay
at this point, so I can't capture the oops text except by
typing it down manually. Besides, I doubt the ppc register
dump would be useful; we know which BUG() was hit.

/Mikael
