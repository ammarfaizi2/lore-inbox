Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUH3UKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUH3UKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUH3UIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:08:42 -0400
Received: from frog.mt.lv ([159.148.172.197]:21155 "EHLO frog.mt.lv")
	by vger.kernel.org with ESMTP id S268886AbUH3UIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:08:22 -0400
From: Dmitry Golubev <dmitry@mikrotik.com>
To: linux-kernel@vger.kernel.org
Subject: embedding 2.6 or more findings on kernel size
Date: Mon, 30 Aug 2004 23:07:35 +0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408302307.35052.dmitry@mikrotik.com>
X-mikrotik.com-Virus_kerajs: Not scanned.
X-mikrotik.com-Virus_un_spam-kerajs: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Compiling the 2.6.8.1 kernel, I found three interesting places (looking very 
quickly, perhaps would find more) when the kernel was compiled with unused 
parts:

1. it compiles everything inside /arch/i386/kernel/cpu/ . From my point of 
view, that is incorrect, especially when choosing processor like Cyrix/VIA C3 
(which is a cyrix, not a transmeta, nexgen or something else) and explicitly 
specifying not to make generic x86 code. Perhaps, choice should be given. 
About 15KB of memory wasted on this...

2. then I found it to compile a synaptics touchpad support - also must be 
optional. Another something like 8KB

3. and the third thing I found is that scsi_ioctl is compiled even if SCSI 
support is taken out... very interesting behaviour... another like 8KB 
wasted... I have no SCSI, no USB MassStorage, no CD-RW, no nothing could 
possibly use SCSI...


Many things could be put on about 100-200KB spared if not migrating to 2.6... 
Perhaps, more controls should be available to configure - new kernels should 
be smaller and faster, not larger, shouldn't they?

Thanks,
Dmitry
