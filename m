Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWECJLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWECJLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWECJLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:11:49 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:13354 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965127AbWECJLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:11:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sfum3Bnli4eZuz1rNOdEPriEm44M+Q+uH5HT5enxl+TRQ31qvOX37wI0QROzbiFGWeOnruuhEFGi6wQ6USC9JWVYshA429FWZ9yEoNlfsAyb2skBUnh6HzWm2/4S6HttyUqJ0CJU1rZlY2NCWH1oRM5zNzDK8J0MfQjMcXKlQbw=
Message-ID: <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com>
Date: Wed, 3 May 2006 11:11:48 +0200
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc3-mm1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20060501014737.54ee0dd5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501014737.54ee0dd5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/
>
>
Hi Andrew,

Since a few -mm releases I am seeing processes stuck in a
nanosleep({0, 0}, NULL) syscall. Sometimes, they unfreeze after
several hours.

The processes are urxvtd (rxvt-unicode daemon) or urxvt (rxvt-unicode terminal).
The backtrace from sysrq-t looks like:
...
urxvtd        S DD965F68     0 12171      1 12367   12598 12078 (NOTLB)
       dd965f38 326cc12f 00004abf dd965f68 dd965f38 631b6900 00000167 326c007b
       003d0900 00000000 0000000a df51f144 df51f030 dfb81030 631b6900 00000167
       003d0900 dd965000 dd965f68 00000001 dd965f50 c032703d 00000001 00000000
Call Trace:
 <c032703d> do_nanosleep+0x3d/0x80   <c012fc68> hrtimer_nanosleep+0x38/0xf0
 <c012fd78> sys_nanosleep+0x58/0x60   <c032818b> sysenter_past_esp+0x54/0x75
...
Showing all blocking locks in the system:
S          urxvtd:12171 [df51f030, 115] (not blocked on mutex)

Was it already reported ? If not I'll test a vanilla kernel and start bisecting.

thanks,

Benoit
