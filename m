Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264440AbRFQC1l>; Sat, 16 Jun 2001 22:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264439AbRFQC1b>; Sat, 16 Jun 2001 22:27:31 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:50948
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S264440AbRFQC1O>; Sat, 16 Jun 2001 22:27:14 -0400
Date: Sat, 16 Jun 2001 23:26:47 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <eepro100@scyld.com>
cc: <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>
Subject: eepro100 problems with 2.2.19 _and_ 2.4.0
Message-ID: <Pine.LNX.4.32.0106161923290.339-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody,

I'm having a ton of problems with a set of boxes that use an onboard
variant of the eepro100. I'm not sure what version it is (#$@#*&$@ Intel
documentation - motherboard is model D815EEA2) but eepro100-diag reports:

eepro100-diag.c:v2.05 6/13/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Intel i82562 Pro/100 V adapter at 0xdf00.
i82557 chip registers at 0xdf00:
  00000000 00000000 00000000 00080002 183f0000 00000000

Okay, now for the bad part. Symptoms:

* slow transfers (internet ftps are the case) hard lock box.
* interactive use hard locks box.
* basic Netperf tests run fine.
* wget of > 20MB files from local server run fine.

Steps to reproduce problem:

* Run large ( > 2MB works ) ftp transfer in box.
* ssh in from another box and attempt an ls -lR /

So it seems that only when the network i/o is low does the lock occur.

I've tried up to now four sets of drivers (all non-modules):

* 2.2.19 straight (Andrey?)
	Kills networking, but stays alive - reports (typed in):
	epro100: cmd_wait for (0xffffff00) timedout with (0xffffff00)!

* 2.2.19 with Donald's eepro100.c scyld:network/
	Hard lock (seems to take longer to hang) - it also creates
	8 devices eth0-eth7!

* 2.2.19 with Donald's eepro100.c fromscyld:network/test/
	Hard lock (pretty fast) - no multiple creation bugs

* 2.4.5 straight
	Hangs ssh connection, reports (typed in):
	epro100: wait_for_cmd_done timeout!
	Data socket timed out:
	eth0: Transmit timed out: status 0050  0c00 at 907/935 command 000c0000.

So now I'm left here stuck with a stupid unworking on-board card.

Donald, Andrey, anyone? have you seen this before? What can I do to help
this get diagnosed properly?

BTW: eepro100-diag reports sleep mode on - this is bad, right? And I can
turn it off?

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311





