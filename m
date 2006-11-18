Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755524AbWKRNNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbWKRNNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbWKRNNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:13:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:5092 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1756308AbWKRNNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:13:13 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Sluggish system responsiveness on I/O
Date: Sat, 18 Nov 2006 14:12:29 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 693
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611181412.29144.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml!

Im currently testing 2.6.19-rc5-mm1. Everything works really fine except the 
little wart with bad multimedia interactivity with a kernel compiling in the 
background. So I tried to narrow it down as much 
as possible.

I did several find's,dd's and cats in parrallel and watched four instances of 
glxgears and also played a little enemy-territory. The interactivity was very 
good, in fact no loss of interactivity at all. This was contrary to what I 
believed the whole time. The loss of interactivity has nothing to do with 
heavy I/O. In fact it happens only when I run a task which is I/O and CPU 
heavy at the same time. That means a single kernel compile (with -j1) is able 
to harm interactivity with glxgears and enemy-territory, but fully loading my 
three disks does no harm at all.

So I tried to nice the make and see what happens:

nice 5 make -j4: Seems to make no difference. Heavy stuttering in glxgears and 
et
nice 10 make -j4: Somewhat better but still unusable with et

everything above nice 15 is usable. nice 19 has full interactivity, that means 
you can't make out a difference between no load and kernel compile while 
playing enemy-territory.

I suspect that it has something to do with the priority boost for I/O hogs. 
But if this is a "general" scheduler problem, then why aren't more people 
complaining about this?

-Christian
