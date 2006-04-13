Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWDMETq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWDMETq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 00:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWDMETq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 00:19:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28060 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964779AbWDMETp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 00:19:45 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kexec: Remove order
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 12 Apr 2006 22:18:23 -0600
In-Reply-To: <20060413030040.20516.9231.sendpatchset@cherry.local> (Magnus
 Damm's message of "Thu, 13 Apr 2006 11:59:39 +0900 (JST)")
Message-ID: <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> Kexec: Remove order
>
> This patch replaces kexec n-order allocation code with 0-order only.
>
> Almost all kexec allocations are 0-order pages already, with the exception of 
> some x86_64 specific code that requests two physically contiguous pages. 
>
> These two physically contiguous pages are easily replaced with two separate
> pages. The second page is kept in an architecture specific pointer that is
> added to struct kimage.
>
> Using 0-order allocations only greatly simplifies kexec porting work to
> the Xen hypervisor.

NACK.

It is a big intrusive patch that makes it impossible to
port to some architectures, and it obscures what you
are really trying to do which is fix x86_64.

Feel free to fix x86_64, to use only page sized allocates.

Until I see a reasonable argument that none of the architectures
currently supported by the linux kernel would need a multi order
allocation for a kexec port am I interested in removing support.

As I recall the alpha had an architectural need for a 32KB
allocation or something like that.

Eric
