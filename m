Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTHLOrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270436AbTHLOrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:47:37 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:3593 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270391AbTHLOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:47:36 -0400
Message-ID: <3F38FE5B.1030102@yahoo.com>
Date: Tue, 12 Aug 2003 10:48:59 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Requested FAQ addition - Mandrake and partial-i686 platforms
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, there is an issue with glibc on versions less than 2.3.1-15 
(and maybe others), where it mistakenly treats CPUs as full i686 
compliant when they only execute a subset of the i686 instructions. For 
example, the VIA C3 supports pretty much everything i686 except CMOV, 
yet the broken versions of glibc will detect it as fully i686 compliant.

 From someone who emailed me privately, this apparently affects K6-III 
as well. Possibly other Cyrix or AMD CPUs are affected, though I don't 
have a complete list.

The problem is that Mandrake 9.1 ships with a broken glibc. So you would 
expect that the incorrectly detected CPUs just wouldn't work. But 
apparently, Mandrake added a CMOV instruction emulator patch to their 
kernel, both the one that ships precompiled and the source rpm.

So people will find that compiling the Mandrake version works fine, yet 
any kernel downloaded from kernel.org, 2.6 or other, will not work at 
all. The symptom is that booting the shiny new kernel will hang after 
"Freeing unused kernel memory". Doing a magic sysreq will reveal that 
/sbin/init is executing do_invalid_op(). You can keep pressing the magic 
sysreq stack dump key, and you will keep getting a new stack trace. 
Caps-lock works, and CTRL-ALT-DEL will reboot the machine.

There are three possible workarounds:
1) Upgrade glibc to a working version. I haven't done this myself, so I 
don't know if the bug has been fixed yet. But it would be the best solution.
2) Remove i686 libraries from glibc. This can be done by 'mv /lib/i686 
/lib/i686.invalid'. This is what I did, and it works. While some 
performance is lost, it's not noticeable, especially given that the 
stock Mandrake kernel is i386 compatible, and so has limited optimization.
3) Reapply the CMOV emulation patch to your downloaded kernel. Not 
recommended since it turns one CPU cycle into 400.

-Brandon

