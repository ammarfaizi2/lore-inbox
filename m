Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUBUI1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 03:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBUI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 03:27:04 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:37317 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S261541AbUBUI0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 03:26:52 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN 
In-reply-to: Your message of "Sat, 21 Feb 2004 08:58:53 BST."
             <20040221075853.GA828@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Feb 2004 19:26:32 +1100
Message-ID: <3762.1077351992@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 08:58:53 +0100, 
Ingo Molnar <mingo@elte.hu> wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> perhaps using a simple 64-bit generation counter would be better.
>> Samba would get a new syscall to get the sum of each generation
>> counter down to the root dentry - a total validation of the pathname.
>> If the counter matches with that in the userspace cache entry then no
>> need to re-create the cache. Such generation counters would be usable
>> for multiple file servers as well. Hm?
>
>generation counters are problematic if they are not persistent. But
>there's a pretty natural persistent 'generation counter' which could be
>used for Samba's purpose: the mtime of the directory ...
>... monotonity is important: two successive directory operations to not be
>possible within the same nanosecond.

Why do you need monotonity?  Samba only cares if the dcache entry
changes, the indicator from kernel to user space does not have to be
monotonically increasing, just different.

