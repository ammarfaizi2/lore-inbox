Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314842AbSDVWFi>; Mon, 22 Apr 2002 18:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSDVWFh>; Mon, 22 Apr 2002 18:05:37 -0400
Received: from dns.m.bonet.se ([194.236.29.2]:3335 "EHLO dns.m.bonet.se")
	by vger.kernel.org with ESMTP id <S314834AbSDVWFh>;
	Mon, 22 Apr 2002 18:05:37 -0400
Message-ID: <3CC47A1E.1050700@nogui.se>
Date: Mon, 22 Apr 2002 23:01:18 +0200
From: Christer Palm <palm@nogui.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: /proc/mounts: \r not escaped
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Sorry to bother you all with a minor issue like this, but I didn't find 
a procfs or general filesystem maintainer on the MAINTAINERS list...

The mangle() function in fs/namespace.c used to escape certain 
characters in the /proc/mounts output should probably escape '\r' in 
addition to those already escaped. This is because '\r' is recognized as 
whitespace by some potential tokenization methods - most notably 
scanf("%s") - and because it can cause confusing output from 'cat 
/proc/mounts' or similar.

Not that your everyday mountpoints have names containing '\r'. OTOH, nor 
is the case with '\t', which, I guess, is on the list for the very same 
reason.

Cheers,
--
Christer Palm



--- linux-2.5.8/fs/namespace.c	Sun Apr 14 21:18:54 2002
+++ linux-2.5.8/fs/namespace.c.palm	Mon Apr 22 21:48:02 2002
@@ -184,7 +184,7 @@

  static inline void mangle(struct seq_file *m, const char *s)
  {
- 
seq_escape(m, s, " \t\n\\");
+ 
seq_escape(m, s, " \t\n\r\\");
  }

  static int show_vfsmnt(struct seq_file *m, void *v)

