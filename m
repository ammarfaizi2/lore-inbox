Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVDOSh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVDOSh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVDOSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:35:54 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:64599 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261893AbVDOSeb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:34:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J7PFtV5gwhqjSPKfB7HzvfatzVMfEmDauIfqrgyXRqXzUoiCEjAxW16oABdujEUcKzBWg8Adi9J5Ie89lZXqYGq60lPqw2FruJfkn7+S4EzW5HlDw2wfRLA+FTdHHdchcK0spb4cp+aJ089m5JW6dF9xDGXPiQfywl99pG7n++4=
Message-ID: <e1e1d5f405041511342af714c1@mail.gmail.com>
Date: Fri, 15 Apr 2005 11:34:29 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Allison <fireflyblue@gmail.com>
Subject: Re: Kernel Rootkits
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d79880504151115744c47bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17d79880504151115744c47bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, LKM's are not the unique way to make code run in kernel. In
fact, we can install a kernel rootkit even when LKM support is
disabled. For example, by patching the kernel memory, you can modify
the behavior of kernel on-the-fly without restart the machine, just
inserting code in the right memory addresses (generally writing to
/dev/mem or /dev/kmem or using another methods like set a userspace
memory limit to KERNEL_DS and write to addressable kernel memory. You
can also insert code into existing kernel modules (for example, your
NIC driver) to be executed when the kernel shuts up). LKMs have the
advantage of relocation (i.e., the kernel's internal function adresses
are "readressed" to fit the existent function addresses and a call to
printk will point to the start of printk function at kernel memory).
Inject executable code at kernel memory can be done without LKM
support, but also, is not automatically relocated. There are some
tricks to make injected code work fine like use only non-global
variables and allocate needed memory space in the stack, or made a
hard relocation of binary code to be injected before the injection,
etc.

Google for things like "suckit". phrack is also a good start.

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
