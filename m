Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282783AbRK0EOR>; Mon, 26 Nov 2001 23:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282785AbRK0EOI>; Mon, 26 Nov 2001 23:14:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:34057 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282783AbRK0ENz>;
	Mon, 26 Nov 2001 23:13:55 -0500
Subject: Re: [PATCH] proc-based cpu affinity user interface
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111261948460.1674-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0111261948460.1674-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 23:14:23 -0500
Message-Id: <1006834464.842.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 22:52, Davide Libenzi wrote:
> As I said in reply to Ingo patch, it'd be better to expose "number" cpu
> masks not "logical" ( like cpus_allowed ).
> In this way the users can use 0..N-1 ( N == number of cpus phisically
> available ) w/out having to know the internal mapping between logical and
> number ids.

Do you mean you don't like using a bitmask ?

00000001 = first CPU, its not logical, its physical.

Plus, how do you intend to set multiple non-contiguous CPUs?  A fraction
of them?  With only a 32-bit value?

Note also that my patch understands the underlying CPU nature, such that
"echo 0000ffff > /proc/123/affinity" will only affine task 123 to your
first 2 CPUs if you only have two.  Thus, "cat /proc/123/affinity" will
return "00000003".

	Robert Love

