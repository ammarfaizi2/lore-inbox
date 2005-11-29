Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVK2QHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVK2QHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVK2QHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:07:46 -0500
Received: from amdext4.amd.com ([163.181.251.6]:43210 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751392AbVK2QHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:07:45 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Enabling RDPMC in user space by default
Date: Tue, 29 Nov 2005 10:56:31 -0600
User-Agent: KMail/1.8
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
References: <20051129151515.GG19515@wotan.suse.de>
In-Reply-To: <20051129151515.GG19515@wotan.suse.de>
MIME-Version: 1.0
Message-ID: <200511291056.32455.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 29 Nov 2005 16:07:20.0859 (UTC)
 FILETIME=[FA53BEB0:01C5F4FE]
X-WSS-ID: 6F92A3321BO230751-02-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 09:15, Andi Kleen wrote:
> Hallo,
>
> I'm considering to enable CR4.PCE by default on x86-64/i386. Currently it's
> 0 which means RDPMC doesn't work. On x86-64 PMC 0 is always programmed to
> be a cycle counter, so it would be useful to be able to access
> this for measuring instructions. That's especially useful because RDTSC
> does not necessarily count cycles in the current P state (already
> the case on Intel CPUs and AMD's future direction seems to also
> to decouple it from cycles) Drawback is that it stops during idle, but
> that shouldn't be a big issue for normal measuring. It's not useful
> as a real timer anyways.
>
> On Pentium 4 it also has the advantage that unlike RDTSC it's not
> serializing so should be much faster.
>
> The kernel change would be to always set CR4.PCE to allow RDPMC
> in ring 3.
>

You might also ping Stephane Eranian and the folks that are working on 
defining a common performance measurement interface in the kernel
over on  perfctr-devel@lists.sourceforge.net and see what they think.
I'll cc them on this reply.

> It would be actually a good idea to disable RDTSC in ring 3 too
> (because user space usually doesn't have enough information to make
> good use of it and gets it wrong), but I fear that will break
> too many applications right now.
>

FWIW, I agree here.   We lock down the power state and still use RDTSC for 
some timing things.

> Any comments on this?
>
> -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

