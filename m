Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUE1Kes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUE1Kes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 06:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUE1Kes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 06:34:48 -0400
Received: from adsl-63-194-232-126.dsl.lsan03.pacbell.net ([63.194.232.126]:56338
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id S262003AbUE1Keq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 06:34:46 -0400
Message-ID: <40B715BE.3070200@alpha.dyndns.org>
Date: Fri, 28 May 2004 03:34:38 -0700
From: Mark McClelland <lists-lud@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
References: <20040527194920.A1709@jurassic.park.msu.ru>
In-Reply-To: <20040527194920.A1709@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> Spinning the disks down across a 'halt' on Alpha is even
> worse than doing that on reboot on i386 (assuming the
> boot device is IDE disk).
> Typically, the sequence to boot another kernel is:
> # halt
> kernel shuts down, firmware re-initializes,
> then on firmware prompt we type something like
> 
>>>>boot -file new_kernel_image.gz
> 
> 
> Unfortunately, the firmware does not expect the IDE drive
> to be in standby mode and reports 'bootstrap failure' on
> the first and all subsequent boot attempts until the
> drive spins up, which is extremely annoying and
> confuses users a lot.
> 
> This patch allows architectures override the default
> behavior (don't spin the disks down on reboot only)
> in asm/ide.h.

This isn't completely safe. I sometimes power off my Alpha after 
rebooting to the monitor program, for various reasons.

Wouldn't it be better to spin the disks down like normal, but then spin 
them back up just before rebooting?

-- 
Mark McClelland
mark@alpha.dyndns.org
