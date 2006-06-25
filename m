Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWFYBlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWFYBlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 21:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFYBlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 21:41:31 -0400
Received: from mail.tbdnetworks.com ([204.13.84.99]:8072 "EHLO
	mail.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S1751303AbWFYBlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 21:41:31 -0400
Subject: Re: OOPS in UDF
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20060623175033.664ddcce.akpm@osdl.org>
References: <20060615155828.GA14257@defiant.tbdnetworks.com>
	 <20060623175033.664ddcce.akpm@osdl.org>
Content-Type: text/plain
Organization: TBD Networks
Date: Sun, 25 Jun 2006 03:40:49 +0200
Message-Id: <1151199649.5824.345.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 17:50 -0700, Andrew Morton wrote:
> On Thu, 15 Jun 2006 08:58:28 -0700
> nkiesel@tbdnetworks.com (Norbert Kiesel) wrote:
> 
> > I just got an OOPS while copying between two loopback-mounted UDF filesystems.
> > One or both of the UDF file systems are corrupted (some files not readable by
> > root), but kernel should not OOPS anyway.
> > 
> > I get the corrupted file systems reliably by rsync'ing big directories onto the
> > UDF filesystem (while trying to prepare a backup DVD).  I saw the OOPS only once
> > so far.  The system continued to work after the OOPS.
> 
> Are you able to get a copy of one of these filesystem images up onto a
> server somewhere so others can reproduce the crash?
> 

I tried to reproduce it by filling a loop-mounted UDF filesystem with multiple
copies of my kernel tree (i.e similar to what I had done when I saw the OOPS).
However, now the "cp -a kernel kernel3" hangs, and so does a simple "w"
or "ps". echo p > /proc/sys/kernel/sysrq shows this for one of the
hanging "ps":
[17442714.056000] ps            D E214EB78     0 10874  10870
(NOTLB)
[17442714.056000]        f1571ed8 00000001 00000008 e214eb78 e214ea70
923e5c00 003df798 00000000
[17442714.056000]        923e5c00 003df798 016e3600 00000000 0000003b
e6ebe5d4 00000000 e214ea70
[17442714.056000]        c02c1d03 000003ab e6ebe5d8 ebcf5ee8 c0e03ee8
e214ea70 00000001 0000003b
[17442714.056000] Call Trace:
[17442714.056000]  <c02c1d03> rwsem_down_read_failed+0x12a/0x144
<c0118b0a> .text.lock.ptrace+0x7/0x25
[17442714.056000]  <c012bc61> __alloc_pages+0xd8/0x270  <c01630da>
proc_pid_cmdline+0x4e/0xdc
[17442714.056000]  <c016344f> proc_info_read+0x37/0x72  <c0163418>
proc_info_read+0x0/0x72
[17442714.056000]  <c013e402> vfs_read+0x9f/0x13e  <c013e766> sys_read
+0x3c/0x63
[17442714.056000]  <c0102443> sysenter_past_esp+0x54/0x75

I'm not sure if this is related to the UDF problem I saw before. The
other thing that changed is that I'm now running a newer kernel compiled
with a newer gcc: Linux version 2.6.17.1 (nkiesel@defiant) (gcc version
4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #84 Wed Jun 21 16:31:05
PDT 2006.

All things not related to proc_info work as usual (e.g. login, vi,
filesystem access).  I can't see the stacktrace for the cp because the
output of sysrq is clipped.  Once I find out how to extend the buffer I
will try to get a stacktrace for that process, too.

I will also reboot using the 2.6.16.19 kernel and check if the same
happens.  However, the machine is 5500 miles away and does not always
boot without intervention, so I have to wait for Monday.

</nk>


