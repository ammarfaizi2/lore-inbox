Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbTGJOFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269278AbTGJOFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:05:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:59373 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266345AbTGJOFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:05:38 -0400
Message-ID: <3F0D761E.2050702@gmx.net>
Date: Thu, 10 Jul 2003 16:20:14 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having read the whole thread, I came up with a few ideas.

The following patches in -pre3 could perhaps have to do something with
your problems:
  o (resend) collected semaphore fixes and semtimedop
  o Fix potential IO hangs and increase interactiveness during heavy IO
  o fix false sharing of mm info
  o fix up semops and return, allow timedop
  o mremap VM_LOCKED move_vma
  o remove io_apic_modify - this doesnt work on some APICs
  o small setup-pci cleanups

Since your hangs are not even traceable with SysRq, please try to boot
with nmi_watchdog=1 and if that doesn't work (dmesg will complain)
nmi_watchdog=2. About 15 seconds after the hang your box should print a
backtrace.

As a last resort you could mount the fs from UML.

I suggest you try the nmi_watchdog thing first.


Carl-Daniel
-- 
http://www.hailfinger.org/

