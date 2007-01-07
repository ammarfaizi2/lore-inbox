Return-Path: <linux-kernel-owner+w=401wt.eu-S932570AbXAGPM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbXAGPM7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbXAGPM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:12:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:46291 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932570AbXAGPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:12:58 -0500
In-Reply-To: <200701070525.45974.vda.linux@googlemail.com>
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com> <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com> <Pine.LNX.4.64.0701040921010.3661@woody.osdl.org> <200701070525.45974.vda.linux@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <11fc5e81b224467e25caaefb66ba82e7@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk,
       Linus Torvalds <torvalds@osdl.org>, bunk@stusta.de, mikpe@it.uu.se
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Sun, 7 Jan 2007 16:10:53 +0100
To: Denis Vlasenko <vda.linux@googlemail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want this:
>
> char v[4];
> ...
> 	memcmp(v, "abcd", 4) == 0
>
> compile to single cmpl on i386. This (gcc 4.1.1) is ridiculous:

>         call    memcmp

i686-linux-gcc (GCC) 4.2.0 20060410 (experimental)

         movl    $4, %ecx        #, tmp65
         cld
         movl    $v, %esi        #, tmp63
         movl    $.LC0, %edi     #, tmp64
         repz
         cmpsb
         sete    %al     #, tmp68

Still not perfect, but better already.  If you have any
specific examples that you'd like to have compiled to
better code, please report them in GCC bugzilla (with a
self-contained testcase, please).


Segher

