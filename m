Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTDIU23 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTDIU22 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:28:28 -0400
Received: from fmr06.intel.com ([134.134.136.7]:50681 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263776AbTDIU21 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:28:27 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBA496@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Michael Buesch'" <freesoftwaredeveloper@web.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Process falls into uninterruptible sleep
Date: Wed, 9 Apr 2003 13:39:59 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Michael Buesch
>
>On Wednesday 09 April 2003 21:39, Perez-Gonzalez, Inaky wrote:
>> uniterruptible processes cannot be killed :)
> I know. :)
> But it shouldn't fall into this sleep.

Do this, try to get again kmail [or any other app to freeze]. When it is
hung in there, do:

$ ps axfwl > ps.log. 

Now get the PID of the guy and do:

$ find /proc/PID -ls -perm a+r -exec cat {} \; > proc.log

Then go to a console and do Ctrl+ScrollLock - get that output from the
klogd->syslogd and look for the entry that matches the hang process and the
PID. Record the trace and send everything. The traces will look like:

kmail         S 00000001 4291079704  4518    394                     (NOTLB)
Call Trace:
 [<c013d3b5>] do_clock_nanosleep+0x1c5/0x360
 [<c011e5c0>] default_wake_function+0x0/0x20
 [<c011e5c0>] default_wake_function+0x0/0x20
 [<c013cfa0>] nanosleep_wake_up+0x0/0x10
 [<c01107c0>] do_gettimeofday+0x20/0xb0
 [<c013d03e>] sys_nanosleep+0x6e/0x100
 [<c0109a7f>] syscall_call+0x7/0xb

I am trying to see what it is exactly waiting for. From your data, it is
evident that it is somewhere in the rw process where he is getting 
stuck, but it needs to be confirmed and traced to a where.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


