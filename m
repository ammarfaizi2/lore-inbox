Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755458AbWKSArb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbWKSArb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbWKSArb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 19:47:31 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2592 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1755458AbWKSAra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 19:47:30 -0500
Date: Sat, 18 Nov 2006 19:47:17 -0500
From: ROBERT HANCOCK <hancockr@shaw.ca>
Subject: Re: ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
To: linux-kernel@vger.kernel.org, christiand59@web.de
Message-id: <cb8795142da89.455f6345@shaw.ca>
MIME-version: 1.0
X-Mailer: Sun Java(tm) System Messenger Express 6.2-7.05 (built Sep  5 2006)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7bit
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian wrote:
> During my I/O load test, after about half an hour of heavy I/O on three SATAII 
> disks the system suddenly hung for about 3 seconds. After that I checked 
> dmesg and found the following error output:
> 
> [ 4574.193809] ata2: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 
> 0x1501000 status 0x400
> [ 4574.193826] ata2: CPB 0: ctl_flags 0x1f, resp_flags 0x1
> [ 4574.193835] ata2: CPB 1: ctl_flags 0x1f, resp_flags 0x2

All this output is from the debugging code I have in the error handler in sata_nv for ADMA mode.

> [ 4574.194366] ata2: Resetting port
> [ 4574.194411] ata2.00: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 
> frozen
> [ 4574.194453] ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)

Hmm, it looks like the controller thinks the command has been sent to the drive and has "released" the command for the drive to do its thing, and hasn't received a response back yet. (At least that's what I believe bit 1 in the response flags means..) This might not be the fault of the controller or driver, it might just be the drive not responding. Can you post some drive information (like full dmesg from bootup)?
