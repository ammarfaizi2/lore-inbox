Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbTCPLmi>; Sun, 16 Mar 2003 06:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbTCPLmi>; Sun, 16 Mar 2003 06:42:38 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:7941 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262657AbTCPLmh>;
	Sun, 16 Mar 2003 06:42:37 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1 
In-reply-to: Your message of "Sun, 16 Mar 2003 03:32:54 -0800."
             <20030316113254.GH20188@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Mar 2003 22:53:19 +1100
Message-ID: <17605.1047815599@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 03:32:54 -0800, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Sun, Mar 16, 2003 at 10:12:24PM +1100, Keith Owens wrote:
>> Some of the 64 bit archs implement test_bit() as taking int * instead
>> of long *.  That generates unoptimized code for the case of NR_CPUS <
>> 64.

Come to think of it, using any of the bitops generates unoptimized code
for cpu mask testing when we know that NR_CPUS will fit into a single
long.  For NR_CPUS <= 8*sizeof(long), using mask & (1UL << cpu) removes
the unnecessary array calculations.

>What's the state of 2.5.x on the big machines where you're at?

I could tell you, but then marketing would kill me :(  Wait a bit.

>Another thought I had was wrapping things in structures for both small
>and large, even UP systems so proper typechecking is enforced at all
>times. That would probably need a great deal of arch sweeping to do,
>especially as a number of arches are UP-only (non-SMP case's motive #2).

Keep the optimized model, where cpu_online_map is #defined to 1 for UP.
Changing it to an ADT just to get type checking on architectures that
only support UP looks like a bad tradeoff.

