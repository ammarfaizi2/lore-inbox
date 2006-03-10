Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWCJDDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWCJDDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCJDDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:03:55 -0500
Received: from smtp-out.google.com ([216.239.45.12]:39453 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750795AbWCJDDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:03:54 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rxw4ytuANYMi/O24Mhbv8U/4tqkEPA7QHd1yGCh2TVjiybXnElMZoat63LiMBle9A
	VRSaIh2/8V5+ZMOOu3u8Q==
Message-ID: <4410EC8A.4020808@google.com>
Date: Thu, 09 Mar 2006 19:03:38 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, dkegel@google.com
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode
 on i386
References: <4410BB32.1020905@google.com> <20060309184759.591e3551.akpm@osdl.org>
In-Reply-To: <20060309184759.591e3551.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> But we don't compile the kernel with -fpic...  We might want to, for kdump
> convenience at some stage, perhaps.

Unless I am really confused, there should be no place in the kernel that 
uses any of the _syscallX() macros. These macros are for the benefit of 
userspace, and they get picked up by and distributed with glibc. They 
just happen to be shipped and maintained with the kernel.

> If we do, it'd be better to simply replace those _syscallX functions with
> versions which work in either mode, rather than having two versions.

That is certainly possible. The new macros work in both modes, but they 
are slightly less efficient than the old macros, if you have access to 
%ebx (i.e. in non-PIC code). If you prefer, we could just remove the old 
macros and unconditionally replace them with the new ones.

> The syscallX() macros are almost obsolete - it's preferred that code simply
> include syscalls.h and call sys_foo() directly.  But there are a few
> hard-to-convert places, iirc.

Are you thinking of the code that jumps through the vdso entry point? 
That is not always an easy option for user-space applications which need 
to remain backwards compatible to older versions of the kernel and of libc.


Markus
