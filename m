Return-Path: <linux-kernel-owner+w=401wt.eu-S1754423AbXACGqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbXACGqu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbXACGqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:46:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34486 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXACGqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:46:49 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Jean Delvare <khali@linux-fr.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
References: <20070103041645.GA17546@in.ibm.com>
Date: Tue, 02 Jan 2007 23:44:34 -0700
In-Reply-To: <20070103041645.GA17546@in.ibm.com> (Vivek Goyal's message of
	"Wed, 3 Jan 2007 09:46:45 +0530")
Message-ID: <m1tzz8k3sd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> o i386 kernel reboots instantly if compiled with binutils older than
>   2.6.15.
>
> o Older binutils required explicit flags to mark a section allocatable
>   and executable(AX). Newer binutils automatically mark a section AX if
>   the name starts with .text.
>
> o While defining a new section using assembler "section" directive,
>   explicitly mention section flags. 

As such this patch looks fine, and is certainly harmless.  But don't we
also need to address the issue that .text.head is not listed in the
linker script?

i.e.  Don't we also need?

  .text : AT(ADDR(.text) - LOAD_OFFSET) {
  	_text = .;			/* Text and read-only data */
+	*(.text.head)
	*(.text)
	SCHED_TEXT
	LOCK_TEXT
	KPROBES_TEXT
	*(.fixup)
	*(.gnu.warning)
  	_etext = .;			/* End of text section */
  } :text = 0x9090


I'm not even certain how the i386 kernel links properly without the above.

Eric
