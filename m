Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTBJEF5>; Sun, 9 Feb 2003 23:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBJEF5>; Sun, 9 Feb 2003 23:05:57 -0500
Received: from kilroy.chi.il.us ([205.243.139.239]:59266 "EHLO
	kilroy.chi.il.us") by vger.kernel.org with ESMTP id <S261375AbTBJEFz>;
	Sun, 9 Feb 2003 23:05:55 -0500
Subject: Larger circular printk log message buffer for kernel?
From: Edward Kuns <ekuns@kilroy.chi.il.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Edward Kuns <ekuns@kilroy.chi.il.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044850803.14790.18.camel@kilroy.chi.il.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Feb 2003 22:20:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me for responses.

I'm willing to make a patch if it is likely to be accepted into the
kernel.  Since we have so many subsystems that spit out kilobytes of
messages, by the time my system has booted up I have already lost some
of the most important boot messages!  (APIC, for example)

I found the important part located in kernel/printk.c as follows in
2.4.21-pre3-ac2:

#if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
#define LOG_BUF_LEN	(65536)
#elif defined(CONFIG_ARCH_S390)
#define LOG_BUF_LEN	(131072)
#elif defined(CONFIG_SMP)
#define LOG_BUF_LEN	(32768)
#else	
#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
#endif

I changed the last one to 32768 and now I see all my boot messages.  I
imagine that people would be against doubling the last two buffers (that
is, SMP = 64k, else = 32k) on all systems.  But 16k is simply too small
for anyone using RAID or USB or APIC or other "noisy" subsystems.
RAID/md is by far the noisiest boot-time subsystem I have configured.

Ideas?  Perhaps a kernel config multiplier defaulting to "1" that can be
changed in "make config" to 2, 4, 8, ...?  I'm willing to do the work
for this, but only if it seems likely to be accepted.  Are there other,
better options?

On systems with large amounts of memory, surely we can afford to give
more of it to the kernel's log message buffer!


	Eddie

-- 
  Eddie Kuns  |  Home: ekuns@kilroy.chi.il.us
--------------/  URL:  (none at the moment)
  "Ah, savory cheese puffs, made inedible by time and fate."  -- The Tick
