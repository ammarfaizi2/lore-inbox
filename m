Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUBTMMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUBTMMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:12:36 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:7578 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261172AbUBTMMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:12:32 -0500
Message-ID: <4035F9AE.6060001@emergence.uk.net>
Date: Fri, 20 Feb 2004 12:12:30 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Double fb_console_init call during do_initcalls
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fb_console_init gets called twice during do_initcalls. Should it be 
called from vty_init or as its own initcall? If it should be its own 
initcall then can it be moved up the list to occur sooner? I think it 
looks better if the fb kicks in as early as possible.


  [<c01d09cc>] take_over_console+0x14a/0x1c9
  [<c031e4c5>] fb_console_init+0x2b/0x59
  [<c031cde4>] vty_init+0xc9/0xd3
  [<c031c5b1>] tty_init+0x234/0x23c
  [<c0310610>] do_initcalls+0x32/0x80
  [<c01050a6>] init+0x2f/0x109
  [<c0105077>] init+0x0/0x109
  [<c0106a81>] kernel_thread_helper+0x5/0xb
Console: switching to colour frame buffer device 128x48


  [<c01d09cc>] take_over_console+0x14a/0x1c9
  [<c031e4c5>] fb_console_init+0x2b/0x59
  [<c0310610>] do_initcalls+0x32/0x80
  [<c01050a6>] init+0x2f/0x109
  [<c0105077>] init+0x0/0x109
  [<c0106a81>] kernel_thread_helper+0x5/0xb
Console: switching to colour frame buffer device 128x48


Jonathan Brown
http://emergence.uk.net/
