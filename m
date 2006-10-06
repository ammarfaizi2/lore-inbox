Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWJFRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWJFRSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWJFRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:18:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:7301 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422764AbWJFRSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:18:02 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45268FB1.6080605@s5r6.in-berlin.de>
Date: Fri, 06 Oct 2006 19:17:37 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394 regression in 2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610052132.11544.s0348365@sms.ed.ac.uk> <4525842F.3040109@s5r6.in-berlin.de> <200610052337.17805.s0348365@sms.ed.ac.uk> <452593AC.3000406@s5r6.in-berlin.de> <45266042.4060107@s5r6.in-berlin.de>
In-Reply-To: <45266042.4060107@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> I saw the messages and the delay that you described now too, using Linux
> 2.6.18 + all IEEE 1394 updates. I will continue to narrow the cause down.

It's as I suspected:
"ieee1394: nodemgr: switch to kthread api, replace reset semaphore"
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=d2f119fe319528da8c76a1107459d6f478cbf28c

Before that, I get a selfID-complete event, then nodemgr starts its
work. After that its the reverse, which lets nodemgr inject a packet
before the bus is completely ready. (So it's actually a regression in
ieee1394 core's high-level functions, not in ohci1394. And it's harmless.)

I will post when I have a fix.
-- 
Stefan Richter
-=====-=-==- =-=- --==-
http://arcgraph.de/sr/
