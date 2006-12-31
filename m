Return-Path: <linux-kernel-owner+w=401wt.eu-S933040AbWLaGwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbWLaGwE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 01:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbWLaGwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 01:52:03 -0500
Received: from [66.28.54.226] ([66.28.54.226]:34270 "EHLO
	vsc.virtualstorageinc.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933040AbWLaGwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 01:52:01 -0500
X-Greylist: delayed 1314 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 01:52:01 EST
Message-ID: <47362.192.168.0.26.1167546604.squirrel@www.virtualstorageinc.com>
Date: Sat, 30 Dec 2006 23:30:04 -0700 (MST)
Subject: sbull example on 2.6.18 fc5 x86_64 has refcount problem
From: "Randy Pierce" <randy.pierce@virtualstorageinc.com>
To: linux-kernel@vger.kernel.org
Reply-To: randy.pierce@virtualstorageinc.com
User-Agent: SquirrelMail/1.4.4-2.cc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I am being dense here. I have been playing with the driver
examples in LDD3 specifically the sbull block level driver example. On
2.6.17 it was running OK after two little fixes ...
comment out include of config.h
and
end_that_request_last(req);
needs to be
end_that_request_last(req,0);
...

On 2.6.18 I now get the wrong refcount after loading the module. Of course
you can't unload the module then because you get ERROR: Module sbull is in
use

cat'ing /proc/modules shows an initial refcount of 8 ??
>cat /proc/modules | grep sbull
sbull 18192 8 - Live 0xffffffff884a1000

dmesg doesn't show any errors, nor does /var/log/messages.

This is my version...
>uname -a
Linux vstore1 2.6.18-1.2257.fc5 #1 SMP Fri Dec 15 16:07:14 EST 2006 x86_64
x86_64 x86_64 GNU/Linux

I am running a dual core AMD 64 bit machine.
What did I miss here? I didn't see anything in the archives. Please CC me
directly if you can help me out randy@virtualstorageinc.com
I really appreciate it. Thank you very much.

randy


