Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTJSJwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTJSJwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 05:52:13 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:57350 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261240AbTJSJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 05:52:11 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Date: Sun, 19 Oct 2003 11:34:38 +0200
Organization: Tiscali Germany
Message-ID: <erltmb.re.ln@127.0.0.1>
References: <FJVJ.4PN.5@gated-at.bofh.it> <I1Yg.6oy.13@gated-at.bofh.it> <I1Yg.6oy.11@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.121.24.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1066556956 75288 62.246.121.24 (19 Oct 2003 09:49:16 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sun, 19 Oct 2003 09:49:16 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Matthias schrieb:

> David Brownell schrieb:
> 
>> David Brownell wrote:
>>> 
>>> Hmm ... maybe usbcore would be better off with a less
>>> naive algorithm for choosing defaults.  Like, preferring
>>> configurations without proprietary device protocols.
>>> That'd solve every cdc-acm case, and likely others.
>> 
>> In fact, here's a patch with that very change.  Does
>> it make current 2.6.0-test kernels work "out of the box"
>> again with your USB modems?
> 
> Yes, it works with ELSA Microlink USB. Thanks.

Hmm. Too early. I get either a "acm: probe of 3-3:2.1 failed with error -5"
but it works or a 
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
 c023d9c3
 *pde = 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[usb_driver_claim_interface+67/112]    Tainted: P
 EFLAGS: 00010202
 EIP is at usb_driver_claim_interface+0x43/0x70
 eax: c02ffe72   ebx: dddcf200   ecx: 00000004   edx: dddfa2ec
 esi: dddfa120   edi: 00000000   ebp: dddce3c0   esp: c15b1dd8
 ds: 007b   es: 007b   ss: 0068
 Process khubd (pid: 5, threadinfo=c15b0000 task=ddf8e040)
 Stack: c030a460 c02ff409 c02ffe72 00001388 dddcf200 c025141c c033a8e0
dddfa2ec
        dddce3c0 dddce3d8 00000007 00000094 dddcf200 00000000 00000020
dddfa120
        c1796ac0 c1796ad4 dddddc00 c033a968 c033a900 c033a8e0 dddfa240
c023d713
 Call Trace:
  [acm_probe+1228/1408] acm_probe+0x4cc/0x580
  [usb_probe_interface+115/160] usb_probe_interface+0x73/0xa0
  [bus_match+63/112] bus_match+0x3f/0x70
  [device_attach+65/160] device_attach+0x41/0xa0
  [bus_add_device+91/160] bus_add_device+0x5b/0xa0
  [device_add+167/272] device_add+0xa7/0x110
  [usb_set_configuration+456/576] usb_set_configuration+0x1c8/0x240
  [usb_new_device+690/992] usb_new_device+0x2b2/0x3e0
  [hub_port_connect_change+461/816] hub_port_connect_change+0x1cd/0x330
  [hub_events+773/848] hub_events+0x305/0x350
  [hub_thread+53/224] hub_thread+0x35/0xe0
  [default_wake_function+0/48] default_wake_function+0x0/0x30
  [hub_thread+0/224] hub_thread+0x0/0xe0
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

 Code: 8b 41 04 89 54 24 10 89 44 24 0c e8 1d b6 ed ff b8 f0 ff ff

Peter


