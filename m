Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTJUUWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTJUUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:22:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8964 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263325AbTJUUWC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:22:02 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Date: 21 Oct 2003 20:12:00 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn43ug$ii5$1@gatekeeper.tmr.com>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
X-Trace: gatekeeper.tmr.com 1066767120 19013 192.168.12.62 (21 Oct 2003 20:12:00 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>,
Norman Diamond <ndiamond@wta.att.ne.jp> wrote:
| Friends in the disk drive section at Toshiba said this:
| 
| When a drive tries to read a block, if it detects errors, it retries up to
| 255 times.  If a retry succeeds then the block gets reallocated.  IF 255
| RETRIES FAIL THEN THE BLOCK DOES NOT GET REALLOCATED.
| 
| This was so unbelievable to that I had to confirm this with them in
| different words.  In case of a temporary error, the drive provides the
| recovered data as the result of the read operation and the drive writes the
| data to a reallocated sector.  In case of a permanent error, the block is
| assumed bad, and of course the data are lost.  Since the data are assumed
| lost, the drive keeps the defective LBA sector number associated with the
| same defective physical block and it does not reallocate the defective
| block.

Sounds right to me. If you relocate the LBA sector then on retry I will
(a) read {something} without error, and (b) it will NOT be my data, and
(c) I will not get back an error to tell me I am reading crap. In other
words, to do anything else would result in my silently getting back bad
data!

What should be done is to relocate after successful retry or after
unsuccessful write, because in both cases the drive has valid data to
relocate.

Blockbusting news, I think they're doing it just right. The object is
not to do a read and get no error, the object is to read and get correct
data, and if that doesn't happen, let the controller, o/s, or
application know about it decide what to do then.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
