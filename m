Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVKKPyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVKKPyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVKKPyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:54:12 -0500
Received: from mx1.suse.de ([195.135.220.2]:4792 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750832AbVKKPyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:54:11 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: adjust ia32entry.S
Date: Fri, 11 Nov 2005 16:53:52 +0100
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4370AFF0.76F0.0078.0@novell.com> <200511111634.44871.ak@suse.de> <4374CBE9.76F0.0078.0@novell.com>
In-Reply-To: <4374CBE9.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111653.52341.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 16:50, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 11.11.05 16:34:44 >>>
> >
> >On Wednesday 09 November 2005 17:10, Jan Beulich wrote:
> >> IA32 compatibility entry points needlessly played with extended
> >> registers. Additionally, frame unwind information was still
>
> incorrect
>
> >> for ia32_ptregs_common (sorry, my fault).
> >
> >What do you mean with needlessly played? That it didn't initialize
> >all on the stack frame? That was more a feature than a bug.
> >Did it cause you problems?
>
> It saved and restored R12-R15, even though these registers have no
> meaning (and are architecturally undefined) when coming from/going to
> 32-bit mode. Problems? No, except that without the extra loads (stores
> don't matter that much I believe) performance is better...

int 0x80 can be called from long mode too. We especially kept 
this option to allow JITs like valgrind to run a 32bit process in a 64bit
image. In this case we shouldn't leak kernel registers.

You're right they normally shouldn't be leaked anyways because the
C ABI will save/restore it. I will think about it.
 
>
> >In general I'm weary of making the asm macros more complex
> >(adding more arguments etc.) Please keep it simple.
>
> Then ignore this, perhaps with the exception of the unwind info
> adjustment.

Can you please resubmit that as a separate patch?

-Andi
