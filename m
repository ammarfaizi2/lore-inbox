Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUABOsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 09:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUABOsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 09:48:40 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:10202 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265607AbUABOsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 09:48:38 -0500
Message-ID: <3FF584C4.2000305@bluewin.ch>
Date: Fri, 02 Jan 2004 15:48:36 +0100
From: Mario Vanoni <vanonim@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, it, fr-fr, de-de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc1-mm1: kernel or NFS problem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a) not in lkml, cc if needed
b) 5 machines otherwise 100% working, congrats
c) test on 4 machines, the 5th is production, taboo
d) top used: 2x 2.0.16, 2x 3.1.0

Scenario:

machine 1: top, sees himself, <1% CPU
machine 2: ssh to machine 1 ; top
machine 1: top sees 2 top's, <1% CPU each
machine 2: reboot with ssh _active_ with top
machine 1: the top from machine 2 is not killed
            and consumes now >99% CPU,
            must be killed explicitly

Same behaviour on 4 machines,
UP's Celeron-1000+512MBmem & P4-3066HT+1GBmem,
dual SMP's P3-550+1GBmem & P3-1266+2GBmem.

Sar(1) -U ALL 1 0 reports the same values as top(1).

It's not a procps problem, same conditions:

machine 1: top and sar -U ALL 1 0
machine 2: ssh to machine 1; sar -U ALL 1 0
machine 1: ps -efw sees sar, top no CPU used
machine 2: reboot with ssh _active_ with sar -U ALL 1 0
machine 1: top no CPU usage, according ps -efw sar -U ALL 1 0
            and corresponding sadc 1 are always active,
            killall sar kills both

The ethernet is 10Mb, mixed RJ and BNC connectors.

Mario

