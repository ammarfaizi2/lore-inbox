Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268965AbUHUK1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268965AbUHUK1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 06:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUHUK1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 06:27:05 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13808 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268965AbUHUK0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 06:26:42 -0400
Date: Sat, 21 Aug 2004 12:26:24 +0200 (MEST)
Message-Id: <200408211026.i7LAQOSc023796@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: levon@movementarian.org, zwane@linuxpower.ca
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se, minyard@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 18:42:05 -0400 (EDT), Zwane Mwaikambo wrote:
>On Thu, 19 Aug 2004, John Levon wrote:
>
>> On Thu, Aug 19, 2004 at 11:16:28AM -0500, Corey Minyard wrote:
>>
>> > >Please use rdpmc() instead of rdmsr() when reading counter registers.
>> > >Ditto in the other places.
>> > >(I know oprofile doesn't, but that's no excuse.)
>>
>> I actually have no idea why we don't use rdpmc().
>
>If i recall, not all the performance counters were accessible via rdpmc
>and being slower.

rdpmc can read any counter's value in kernel mode, on all
x86 processors supported by oprofile (P6, P4, K7, K8).
On early steppings of the Pentium Pro it's necessary to
disable user-space use of rdpmc due to an erratum, but
there's no problem with using rdpmc in kernel-mode. Early
P5s don't have rdpmc, but they are irrelevant for oprofile.

Using rdpmc to read a counter is universally faster than doing
it with rdmsr. perfctr has benchmarking data to back this up;
see etc/costs/ in recent perfctr packages for details.

However, rdpmc can't read the counters' control registers.
