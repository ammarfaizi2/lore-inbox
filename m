Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUAEWAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265936AbUAEWAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:00:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:40945 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265914AbUAEWAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:00:15 -0500
Date: Mon, 5 Jan 2004 23:00:10 +0100 (MET)
Message-Id: <200401052200.i05M0AX0002410@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: arjanv@redhat.com, schierlm@gmx.de
Subject: Re: Local APIC bug?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 21:07:28 +0100, Michael Schierl wrote:
>>> However, I'd appreciate if someone had any idea why the kernel crashes
>>> when trying to resume. Deadlocks...?
>>
>>most bioses on laptops that I have seen don't actually restore the apic
>>state on resume (since they don't expect the apic to be used at all)
>>which results in entirely horked irq's on resume -> kernel crashes.

Our local APIC PM code saves the local APIC state and disables it
before suspend, and restores it and reenables the local APIC after
resume.

>Thanks. However, my laptop crashes on *suspend* when APIC is on and on
>*resume* when APIC is off...
>
>And on -test3 it did not crash. 
>
>jftr: on 2.4.x it crashed on resume as well. Someone trying to prevent
>me to use stable kernels on my laptop? ;-(

Do you use APM? How do you suspend? With "apm --suspend" or by e.g.
closing the lid? In the latter case, does your APM BIOS post the
suspend event to us before actually suspending?

An APM BIOS that crashes in SMM code before posting the suspend event,
or that skips posting the event altogether, probably won't work with
an enabled local APIC. Not much we can do about that.

/Mikael
