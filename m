Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUHIPHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUHIPHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUHIPHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:07:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:21224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266657AbUHIPE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:04:59 -0400
Date: Mon, 9 Aug 2004 17:04:58 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org, pluto@pld-linux.org
MIME-Version: 1.0
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <13013.1092063898@www53.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Sam,

i think i reached the root cause of my problem:

bash# export AFLAGS_vmlinux.lds.o=123
export: AFLAGS_vmlinux.lds.o=123: not a legal variable name

the problem seems to be raised by dots beeing part of the variable name.

my version of bash is reported like shown here in the environment:
BASH_VERSION=1.14.5(1)

unfortunately the whole build process, including GNU Make 3.80,
fails absolutely silently for this specific point of system error.

sorry that i am feeling unable right now to provide a fix.
maybe some more research is needed to find a viable solution.
in worst case the whole makefile system has to be patched
for any such variable construct. 

on the other side it does look like the normal recursive call sheme
of make is immune to such bash habits, is it? (supposed it launches
itselves directyl and not embedded in a few other shell commands...)

i am not totally sure about that all - especially because i tried
a newer shell which exposed the very same limitation, but there must
be something in that area because i could fiddle out that the var
setting gets lost all the time when calling "scripts/Makefile.build".

-Alex.

-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

