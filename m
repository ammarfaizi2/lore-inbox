Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTIERcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbTIERcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:32:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12558 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S265756AbTIERcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:32:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Subject: Re: nasm over gas?
Date: Fri, 5 Sep 2003 20:28:37 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309050128.47002.insecure@mail.od.ua> <200309052058.11982.mhf@linuxmail.org>
In-Reply-To: <200309052058.11982.mhf@linuxmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200309052028.37367.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 15:59, Michael Frank wrote:
> Just got another reply to this thread which helps to explain what I meant
> by "better coders in 98+% of applications"
>
> On Friday 05 September 2003 19:42, Jörn Engel wrote:
> > How big is the .text of the asm and c variant?  If the text of yours
> > is much bigger, you just traded 2fish performance for general
> > performance.  Everything else will suffer from cache misses.  Forget
> > your microbenchmark, your variant will make the machine slower.

A random example form one small unrelated program (gcc 3.2):

main:
        pushl   %ebp
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        subl    $32, %esp
        xorl    %ebp, %ebp
        cmpl    $1, 52(%esp)
        movl    $0, 20(%esp)
        movl    $1000000, %edi      <----
        movl    $1000000, 16(%esp)  <----
        movl    $0, 12(%esp)
        movl    $.LC27, 8(%esp)
        je      .L274
        movl    $1, %esi
        cmpl    52(%esp), %esi
        jge     .L272

No sane human will do that.

main:
        pushl   %ebp
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        subl    $32, %esp
        xorl    %ebp, %ebp
        cmpl    $1, 52(%esp)
        movl    $0, 20(%esp)
        movl    $1000000, %edi
        movl    %edi, 16(%esp)	<-- save 4 bytes
        movl    %ebp, 12(%esp)  <-- save 4 bytes
        movl    $.LC27, 8(%esp)
        je      .L274
        movl    $1, %esi
        cmpl    52(%esp), %esi
        jge     .L272

And this is only from a cursory examination.

> There is another technical argument - which I am not very familiar with:
> Modern and future CPU's are optimized for high level languages, it is
> just too troublesome to arrange all the instructions best-case for the
> hardware to be well utilized.

You took marketspeak too seriously.

> Back to my original message, my implied definition of "Better coders"
> is the compromise between performance, development effort, stability
> and security (and more).
>
> It does not just refer to the best possible "perfect" code.
>
> Let me give you a example of "best possible code" (to the best of my
> ability):
>
> I do mostly embedded applications,  years ago did consumer design for this
> kind of Hong Kong made $19.99 gimmicks ($6 FOB) priced to be purchased
> "on impulse" by joe consumer.
>
> For one of those gimmicks, I used a 4bit running on 1.5V with 1K
> instruction ROM and 64 nibbles RAM doing 32KIPS (32768 instructions per
> second) to establish the speed of a tennis ball it was built into.
> It required floating point calculations and display on a built-in
> LCD display with 64 segments.
>
> This takes __clever__ __optimized__ code, and is at least a week of work,
> and affordable only in high-volume applications.
>
> Consider, one week of work for what you can do in C using GLIBC within
> 1 hour or less!
>
> Now, please consider a real life (linux) system, which you use everyday,
> of course you could make every piece of code "better" by hand coding and
> optimizing, but what is the real benefit?
>
> Assuming these millions of lines of C having been implemented in optimized
> assembly, could it perform that much faster (if that is what you call
> "better"), or would you use "half" the memory for the same job?
>
> Now, what about it's stability and maintainability - not to mention COST,
> even you could find all those great human coders?
>
> Guess the pioneering days are over ;)

What gives you an impression that anyone is going to rewrite linux in asm?
I _only_ saying that compiler-generated asm is not 'good'. It's mediocre.
Nothing more. I am not asm zealot.
-- 
vda
