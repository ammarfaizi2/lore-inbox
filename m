Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSKSSOp>; Tue, 19 Nov 2002 13:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKSSOp>; Tue, 19 Nov 2002 13:14:45 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:43996 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S267044AbSKSSOn>; Tue, 19 Nov 2002 13:14:43 -0500
Date: Tue, 19 Nov 2002 13:20:54 -0500
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: szonyi calin <caszonyi@yahoo.com>
Subject: Re: Performance improvement with Akira Tsukamoto's Athlon copy_user patch
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20021119173416.16110.qmail@web40604.mail.yahoo.com>
References: <20021119173416.16110.qmail@web40604.mail.yahoo.com>
Message-Id: <20021119130035.5459.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [138.89.33.207] at Tue, 19 Nov 2002 12:21:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calin,

> 2.5.47 with copy user patch
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.71 seconds =180.28 MB/sec
>  Timing buffered disk reads:  64 MB in  4.06 seconds = 15.78 MB/sec
> 
> 
> vanila 2.5.47
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.09 seconds =117.32 MB/sec
>  Timing buffered disk reads:  64 MB in  4.05 seconds = 15.78 MB/sec

Thank you for trying, 
I also been using for compiling kernel for several days,
but, as Andi mentioned, currently the aki_copy is *dangerous* 
when any processes/threads ara using fpu register.

I read the code of laze FPU state saving and confirmed that 
if the function does not generate exception than
'kernel_fpu_begin/end()' should assure fpu safe inside kernel.

However, it is not enough where exception could rise, as Takahashi
mentioned.

I also have benchmark for small buffer which is enough to fit in cache
which I would like to show that aki_copy does perform well for this 
circumstances. 
But I have something urgent todo(homework :)) and I will come back to it
as soon as possible.

Thank you,

Akira Tsukamoto

On Tue, 19 Nov 2002 18:34:16 +0100 (CET)
szonyi calin <caszonyi@yahoo.com> mentioned:

> Hello everybody 
> 
> I patched yesterday the 2.5.47 vanilla kernel with Akira
>  Tsukamoto's Athlon copy_user patch and tried a 
> hdparm -tT /dev/hda 
> 
> The results (atached) are impressive compared with both the 
> vanilla 2.5.47 kernel and the 2.4.19 with ck-rl5 patches (from
>  colivas)
> 
> Bye
> 
> Calin
> 
> 
> 
> =====
> --
> A mouse is a device used to point at 
> the xterm you want to type in.
> Kim Alm on a.s.r.
> 
> ___________________________________________________________
> Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran軋is !
> Yahoo! Mail : http://fr.mail.yahoo.com

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


