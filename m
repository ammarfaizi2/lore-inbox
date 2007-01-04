Return-Path: <linux-kernel-owner+w=401wt.eu-S965035AbXADREV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbXADREV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbXADREV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:04:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:29398 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbXADREU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:04:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BLNgOXvwoHgkL16MMvYuwnikYknwNk7uC2JAWe1yy9zoxbcVMtOz5pZu+VxuwiIm3DxY9DPW1cCCmfXDEQibu1iBfpNLYlQIVJQpIx0c3Mjahhvq2RGTAffnpCfm6EQE2Xgjb3qUfno/2/FsepeoLPW+RxAdRo2InrW/xQGbyJA=
Message-ID: <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
Date: Thu, 4 Jan 2007 12:04:18 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: kernel + gcc 4.1 = several problems
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk,
       bunk@stusta.de, mikpe@it.uu.se, torvalds@osdl.org
In-Reply-To: <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
	 <27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > Adjusting gcc flags to eliminate optimizations is another way to go.
> > Adding -fwrapv would be an excellent start. Lack of this flag breaks
> > most code which checks for integer wrap-around.
>
> Lack of the flag does not break any valid C code, only code
> making unwarranted assumptions (i.e., buggy code).

Right, if "C" means "strictly conforming ISO C" to you.
(in which case, nearly all real-world code is broken)

FYI, the kernel also assumes that a "char" is 8 bits.
Maybe you should run away screaming.

> > The compiler "knows"
> > that signed integers don't ever wrap, and thus eliminates any code
> > which checks for values going negative after a wrap-around.
>
> You cannot assume it eliminates such code; the compiler is free
> to do whatever it wants in such a case.
>
> You should typically write such a computation using unsigned
> types, FWIW.
>
> Anyway, with 4.1 you shouldn't see frequent problems due to

Right, it gets much worse with the current gcc snapshots.

IMHO you should play such games with "g++ -O9", but that's
a discussion for a different mailing list.

> "not using -fwrapv while my code is broken WRT signed overflow"
> yet; and if/when problems start to happen, to "correct" action
> to take is not to add the compiler flag, but to fix the code.

Nope, unless we decide that the performance advantages of
a language change are worth the risk and pain.
