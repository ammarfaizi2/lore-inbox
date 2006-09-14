Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWINEp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWINEp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 00:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWINEp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 00:45:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10625 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751317AbWINEp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 00:45:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: torvalds@osdl.org, jeremy@goop.org, mingo@elte.hu, ak@suse.de,
       arjan@infradead.org, zach@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>
Date: Wed, 13 Sep 2006 22:44:26 -0600
In-Reply-To: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>
	(Albert Cahalan's message of "Thu, 14 Sep 2006 00:06:04 -0400")
Message-ID: <m11wqf12hh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> I think that would be a lower chance, not a greater chance.
> Reasons why an app might care:
>
> a. identify a 64-bit kernel
> b. far jumps between 32-bit and 64-bit code
> c. reload of ds/es after a string operation on thread-private data
>
> Perhaps i386 should change to match x86_64.

I agree that the difference is annoying.

However I just wrote a user space implementation of fork that
is capable of copying a process from an i386 only kernel to a x86_64
kernel, and executing there without having to detect the kernel type.

It didn't takes hacks to accomplish that.

The basic syscall is:
int set_thread_area (struct user_desc *u_info);
struct user_desc {
	unsigned int  entry_number;
	unsigned long base_addr;
	unsigned int  limit;
	unsigned int  seg_32bit:1;
	unsigned int  contents:2;
	unsigned int  read_exec_only:1;
	unsigned int  limit_in_pages:1;
	unsigned int  seg_not_present:1;
	unsigned int  useable:1;
};

If entry_number is -1 the kernel finds a free gdt entry and
sets up the segment and returns with entry_number set to the
segment number.

Eric
