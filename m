Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVKKVhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVKKVhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVKKVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:37:04 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:44020 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751235AbVKKVhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:37:03 -0500
Message-ID: <43750EFD.3040106@mvista.com>
Date: Fri, 11 Nov 2005 13:37:01 -0800
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Calibration issues with USB disc present.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

Have you run into this.  One of the USB disc controllers has the ability to boot the system, 
however, it needs SMM code to do this.  This SMM code, somehow, causes SMI interrupts (which are 
higher priority than NMI interrutps and not maskable) which it needs to do its thing.

Problem is that if one of these occurs while calibrating the TSC or the delay code, it can cause a 
wrong result.  We have seen both a too long and a too short result (depending on where the interrut 
happens).

They have found the root cause of TSC calibration problem.
Now they ask for the fix or workaround.

That is the BIOS is periodically interrupted by USB controller and the CPU
waits during the processing of these interrupts.
Their experiments say the interrupt interval is 260mSec and the BIOS needs
150uSec - 200uSec for processing.
It is proved that the problem doesn't reproduce by masking such SMI in BIOS.
They say SMI is for BIOS emulation for connecting legacy devices to USB.
Without such an emulation it's impossible to boot from USB-FD for instance,
they say too.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
