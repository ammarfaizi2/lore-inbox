Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbTIPIgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIPIgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:36:12 -0400
Received: from host251-89.pool80180.interbusiness.it ([80.180.89.251]:62933
	"EHLO dedasys.com") by vger.kernel.org with ESMTP id S261480AbTIPIgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:36:09 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.22: repeatable panic with "modprobe ide-scsi"
From: davidw@dedasys.com (David N. Welton)
Date: 16 Sep 2003 10:37:03 +0200
Message-ID: <87smmxku34.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Please CC replies to me. ]

Hi,

On a plain old 2.4.22 system that worked fine as 2.4.21, I get kernel
panics every time I do 'modprobe ide-scsi'.

I'm not much of a kernel guy, and there is so much related information
that I'll hold off on pulling it together until someone sends me a
laundry list.

But just to give you an idea:

Sep 16 02:05:02 localhost vmunix: hdc: attached ide-scsi driver.
Sep 16 02:05:02 localhost vmunix: scsi2 : SCSI host adapter emulation for IDE ATAPI devices
Sep 16 02:05:02 localhost vmunix: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 16 02:05:02 localhost vmunix:  printing eip:
Sep 16 02:05:02 localhost vmunix: 00000000
Sep 16 02:05:02 localhost vmunix: *pde = 00000000
Sep 16 02:05:02 localhost vmunix: Oops: 0000
Sep 16 02:05:02 localhost vmunix: CPU:    0
Sep 16 02:05:02 localhost vmunix: EIP:    0010:[<00000000>]    Not tainted
Sep 16 02:05:02 localhost vmunix: EFLAGS: 00010202
Sep 16 02:05:02 localhost vmunix: eax: c02d24d4   ebx: c02d2584   ecx: 00000000   edx: 00000170
Sep 16 02:05:02 localhost vmunix: esi: caef1260   edi: cbd05e80   ebp: 00000003   esp: cafb7b48
Sep 16 02:05:02 localhost vmunix: ds: 0018   es: 0018   ss: 0018
Sep 16 02:05:02 localhost vmunix: ds: 0018   es: 0018   ss: 0018
Sep 16 02:05:02 localhost vmunix: Process modprobe.moduti (pid: 595, stackpage=cafb7000)
Sep 16 02:05:02 localhost vmunix: Stack: d0855ab9 c02d2584 caef1260 0000000c 00000000 00000003 c02d2584 c02d2584 
Sep 16 02:05:02 localhost vmunix:        00000000 cf31a320 c01a197c c02d2584 caef1260 00000000 00000088 00000003 
Sep 16 02:05:02 localhost vmunix:        00000000 00000000 cbafd6c0 00000000 00000006 c02d2584 c12d0160 cf31a320 
Sep 16 02:05:02 localhost vmunix: Call Trace:    [<d0855ab9>] [<c01a197c>] [<c01a1add>] [<c01a2221>] [<c01a2152>]
Sep 16 02:05:02 localhost vmunix:   [<d085671c>] [<c01ae9d0>] [<c01a8de9>] [<c01ae9d0>] [<c01ae720>] [<c01b04a5>]
Sep 16 02:05:02 localhost vmunix:   [<c01af8f8>] [<c01af978>] [<c01a8f0c>] [<c01a8870>] [<c01b2a58>] [<c01956b3>]
Sep 16 02:05:02 localhost vmunix:   [<c0197480>] [<c0197600>] [<c0197480>] [<c01b0d70>] [<c01b25e1>] [<c0187482>]
Sep 16 02:05:02 localhost vmunix:   [<c01d4b67>] [<c018c4cb>] [<c018b7ad>] [<c0116712>] [<c0116805>] [<d0857740>]
Sep 16 02:05:02 localhost vmunix:   [<c0116a40>] [<d0857740>] [<d0857740>] [<c01a9f9f>] [<d08568ee>] [<d0857740>]
Sep 16 02:05:02 localhost vmunix:   [<d0857740>] [<c0117932>] [<d0855060>] [<d0855060>] [<c01073cf>]
Sep 16 02:05:02 localhost vmunix: 
Sep 16 02:05:02 localhost vmunix: Code:  Bad EIP value.

After that, it waits a little bit, then something appears to time out
(the SCSI request?) and a second panic occurs which is the point of no
return.

I had a stab at tracking things down, and the last call frame seemed
to indicate that the code was passing through:

		return (DRIVER(drive)->do_request(drive, rq, block));

on line 660 of ide-io.c

I made the assumption that 'do_request' in this case was ide-cd,
because the drive is hdc, a cdrom, however, in the associated
function, I couldn't get it to do a printk before the panic occured,
so I'm not sure exactly where it wandered off to, and am in over my
head as far as doing more diagnostics.

I don't have unlimited quantities of time, but if someone were
interested in trying to figure this out, I would be willing to work
with them, trying different things.

Thankyou for your time and attention,
-- 
David N. Welton
   Consulting: http://www.dedasys.com/
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
