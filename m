Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTHOQsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270082AbTHOQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:48:12 -0400
Received: from a141.shuttle.de ([194.95.224.141]:61970 "EHLO a141.shuttle.de")
	by vger.kernel.org with ESMTP id S270618AbTHOQr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:47:56 -0400
Date: Fri, 15 Aug 2003 18:47:53 +0200
From: Joerg Hoh <joerg@devone.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] ide-scsi problems on 2.6.0-test2/3 (oops)
Message-ID: <20030815164753.GA3450@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have installed kernel 2.6.0-test2 and and ide-scsi loaded as module;
dmesg shows (without a medium in the drive),

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: abort called for 1
bad: scheduling while atomic!
Call Trace:
 [<c01199e4>] schedule+0x3b4/0x3c0
 [<c010809c>] __down+0x8c/0x100
 [<c0119a50>] default_wake_function+0x0/0x30
 [<c011d5fc>] call_console_drivers+0x5c/0x120
 [<c01082bf>] __down_failed+0xb/0x14
 [<c02a0e62>] .text.lock.scsi_error+0x37/0x55
 [<c02a0670>] scsi_sleep_done+0x0/0x20
 [<fc94a989>] idescsi_abort+0xf9/0x110 [ide_scsi]
 [<c029ffe2>] scsi_try_to_abort_cmd+0x62/0x80
 [<c02a0110>] scsi_eh_abort_cmds+0x40/0x80
 [<c02a0b03>] scsi_unjam_host+0xa3/0xd0
 [<c02a0c0a>] scsi_error_handler+0xda/0x120
 [<c02a0b30>] scsi_error_handler+0x0/0x120
 [<c0107299>] kernel_thread_helper+0x5/0xc

Mounting a medium (over the scsi emulation) works, and then no error
appears.

When I tried updating to linux-2.6.0-test3 (on -test3bk1 this also happens)
the kernel oops while loading the ide-scsi module. 

Jörg

-- 
Wenn ihr Administratoren so gemein zu den Leuten seid, dann wandern
immer mehr Personen in die Hackerszene ab, und letztlich wird es auch
mehr Terrorismus geben, aber das ist euch vermutlich egal.
 -- Jasper Riedel in <99297025.0306270737.76760311@posting.google.com>
