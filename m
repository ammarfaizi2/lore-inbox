Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWHUVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHUVDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWHUVDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:03:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:178 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751102AbWHUVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:03:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
Date: Mon, 21 Aug 2006 15:02:58 -0600
In-Reply-To: <20060821095328.3132.40575.sendpatchset@cherry.local> (Magnus
	Damm's message of "Mon, 21 Aug 2006 18:54:16 +0900 (JST)")
Message-ID: <m13bbpu7i5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> x86_64: Reload CS when startup_64 is used.
>
> The current x86_64 startup code never reloads CS during the early boot process
> if the 64-bit function startup_64 is used as entry point. The 32-bit entry 
> point startup_32 does the right thing and reloads CS, and this is what most 
> people are using if they use bzImage.
>
> This patch fixes the case when the Linux kernel is booted into using kexec
> under Xen. The Xen hypervisor is using large CS values which makes the x86_64
> kernel fail - but only if vmlinux is booted, bzImage works well because it
> is using the 32-bit entry point.
>
> The main question is if we require that the boot loader should setup CS
> to some certain offset to be able to boot the kernel. The sane solution IMO
> should be that the kernel requires that the loaded descriptors are correct, 
> but that the exact offset within the GDT the boot loader is using should not 
> matter. This is the way the i386 boot works if I understand things correctly.

What extra reload of cs does Xen introduce?

I'm not really comfortable with a half virtualized case.

Eric
