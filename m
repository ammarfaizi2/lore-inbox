Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbTHWRAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTHWQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:57:58 -0400
Received: from kom-pc-aw.ethz.ch ([129.132.66.20]:35558 "HELO
	kom-pc-aw.ethz.ch") by vger.kernel.org with SMTP id S263056AbTHWPNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:13:37 -0400
Date: Sat, 23 Aug 2003 17:13:36 +0200
From: Arno Wagner <wagner@tik.ee.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.0-test3: dmesg buffer still too small
Message-ID: <20030823151336.GB4266@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been patching my kernels for too small dmesg 
buffer size (LOG_BUF_LEN in kernel/printk.c in 2.6.x)
for almost 2 years now. I have a single CPU Athlon 
system and get 25kB bootup messages. On other similar
machines I get 22kB, 16kB and 15kb, the two latter
without RAID

Since 2.6.x still seems to have the insufficient 16kB
buffer size ad default, I now consider this to be
a bug that would be best fixed now while 2.6.x is still
evolving.

Fix: 

a) Make it at least 32kB or better 64kB as
   default for standard PC architectures, i.e.
   set CONFIG_LOG_BUF_SHIFT to 16 in linux/kernel.h
   for these architectures.
or

b) Add a configuration option to set the buffer size
   in kernel configuration.

Doing both would probably be best.

I can continue patching my kernel manually (although it
is annoying and I have to katch printk.c to ignore 
CONFIG_LOG_BUF_SHIFT), but others might not have the 
expertise to do so. And showing all these nice messages 
to the user with no way to retrieve them afterwards is
probaly not a good idea...

Arno

-- 
Arno Wagner, Communication Systems Group, ETH Zuerich, wagner@tik.ee.ethz.ch
GnuPG:  ID: 1E25338F  FP: 0C30 5782 9D93 F785 E79C  0296 797F 6B50 1E25 338F
----
For every complex problem there is an answer that is clear, simple, 
and wrong. -- H L Mencken
