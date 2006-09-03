Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWICRFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWICRFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWICRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 13:05:55 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:33625 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751429AbWICRFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 13:05:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c9IvHmHGpsP3Qb/csAjmrNuDSdg4fACV2n20dRre03D0MdqQhDovq3QZFeZJCY+4CeU74F459v5oPcpWA1mJEOpfhsXchPEbQbtNwE912EXnFG3x4a1Hslx9C4AkQRq6jArIYmxDGsF+QJV7goibxPtE1+bNIYb1eO0cPEyDFHc=
Message-ID: <a44ae5cd0609031005u263aebebr6e53fb59e0153d0a@mail.gmail.com>
Date: Sun, 3 Sep 2006 10:05:54 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES too low!
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060903125458.GA21390@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
	 <20060903125458.GA21390@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Miles Lane <miles.lane@gmail.com> wrote:
>
> > Sorry Andrew.  I don't see clues here to help me target the report to
> > a maintainer. I hope this helps.
> >
> > BUG: MAX_STACK_TRACE_ENTRIES too low!
> > turning off the locking correctness validator.
>
> Miles, could you try the patch below? (Andrew: if this solves Miles'
> problem then i think this is v2.6.18 material too. [The other
> possibility would be some permanent stack-trace entries leak, in which
> case the patch will not help. If that happens then we'll have to debug
> this some more.])
>
>         Ingo
>
> ---------------->
> From: Ingo Molnar <mingo@elte.hu>
> Subject: lockdep: double the number of stack-trace entries
>
> Miles Lane reported the "BUG: MAX_STACK_TRACE_ENTRIES too low!" message,
> which means that during normal use his system produced enough lockdep
> events so that the 128-thousand entries stack-trace array got exhausted.
> Double the size of the array.
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/lockdep_internals.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux/kernel/lockdep_internals.h
> ===================================================================
> --- linux.orig/kernel/lockdep_internals.h
> +++ linux/kernel/lockdep_internals.h
> @@ -27,7 +27,7 @@
>   * Stack-trace: tightly packed array of stack backtrace
>   * addresses. Protected by the hash_lock.
>   */
> -#define MAX_STACK_TRACE_ENTRIES        131072UL
> +#define MAX_STACK_TRACE_ENTRIES        262144UL
>
>  extern struct list_head all_lock_classes;
>
>

Ingo, there seemed to be a difference between the file you editted and
 the one in Andrew's tree.  I remade you patch so it applies cleanly.
I'll test and let you know.  One word of caution, I only hit the
problem once and I'm not sure how to trigger the condition.  I'll do
my best.

Thanks,
        Miles

--- kernel/lockdep_internals.h~ 2006-09-03 09:59:29.000000000 -0700
+++ kernel/lockdep_internals.h  2006-09-03 10:00:55.000000000 -0700
@@ -27,7 +27,7 @@
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES        131072UL
+#define MAX_STACK_TRACE_ENTRIES        262144UL

 extern struct list_head all_lock_classes;

-- 
VGER BF report: H 0.0351707
