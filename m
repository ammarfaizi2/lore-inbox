Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWE3W3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWE3W3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWE3W3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:29:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:678 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932524AbWE3W3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:29:32 -0400
Date: Wed, 31 May 2006 00:29:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530222954.GA3746@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com> <20060530220931.GA32759@elte.hu> <20060530221850.GA1764@elte.hu> <20060530222608.GA3274@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530222608.GA3274@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > PREEMPT wasnt the problem but CONFIG_DEBUG_STACKOVERFLOW (at least). 
> > There's some other debug option that seems incompatible too - i'm 
> > still trying to figure out which one.
> 
> narrowed it down to:

CONFIG_PROFILE_LIKELY it is, please disable it in your config, along 
with CONFIG_DEBUG_STACKOVERFLOW:

--- .config.good02	2006-05-31 00:28:35.000000000 +0200
+++ .config.bad01	2006-05-31 00:22:28.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc5-mm1-lockdep
-# Wed May 31 00:26:04 2006
+# Wed May 31 00:19:45 2006
 #
 CONFIG_X86_32=y
 CONFIG_GENERIC_TIME=y
@@ -1819,7 +1819,7 @@ CONFIG_STACK_UNWIND=y
 CONFIG_FORCED_INLINING=y
 CONFIG_DEBUG_SYNCHRO_TEST=y
 CONFIG_RCU_TORTURE_TEST=y
-# CONFIG_PROFILE_LIKELY is not set
+CONFIG_PROFILE_LIKELY=y
 # CONFIG_WANT_EXTRA_DEBUG_INFORMATION is not set
 # CONFIG_KGDB is not set
 CONFIG_EARLY_PRINTK=y

	Ingo
