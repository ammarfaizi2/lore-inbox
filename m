Return-Path: <linux-kernel-owner+w=401wt.eu-S964840AbXADNAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbXADNAJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbXADNAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:00:09 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:61758 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbXADNAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:00:06 -0500
Subject: Re: Patch to fixe Data Acess error in dup_fd
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Zhao Yu Wang <wangzyu@cn.ibm.com>,
       Pavel Emelianov <xemul@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1163768910.12593.19.camel@legolas.in.ibm.com>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
	 <20061114181656.6328e51a.vsu@altlinux.ru>
	 <1163530154.4871.14.camel@impinj-lt-0046>
	 <20061114204236.GA10840@procyon.home>
	 <1163540156.5412.9.camel@impinj-lt-0046>
	 <1163576300.8208.14.camel@legolas.in.ibm.com>
	 <1163578540.4987.7.camel@localhost.localdomain>
	 <1163768910.12593.19.camel@legolas.in.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 04 Jan 2007 18:40:06 +0530
Message-Id: <1167916207.3495.19.camel@legolas.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me for the late response

On Fri, 2006-11-17 at 18:38 +0530, Sharyathi Nagesh wrote:

> > I'm guessing that you've already tried this, but it never hurts to be
> > sure: does this machine pass memtest? :)
    Machine passes memtest without fail, even after running for many
hours.
    Since the problem looked genuine to me and may hit again in future
do let me know how I should improve the patch. Please let us know of the
opinion...
---------------------------------------------------------------------
To restate the problem:
Data access error was observed after testing IO and TCP Stress test for
more than 72 hrs over ppc-64 machine.

[c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
[c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
[c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
[c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
[c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
[c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc
--- Exception: c00 (System Call) at 000000000fee9c60

The location of the problem was 
-----------
for (i = open_files; i != 0; i--) {
                struct file *f = *old_fds++;
                if (f) {
                        get_file(f); <== Get file does increment of f_count of 
     
                                         struct file
                } else {
-----------
in kernel/fork.c.Accessing f_count gives Data access error as 'struct file' pointer f is 
pointing to invalid location

Regards
Sharyathi Nagesh

