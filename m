Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319342AbSHNVLy>; Wed, 14 Aug 2002 17:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319348AbSHNVKr>; Wed, 14 Aug 2002 17:10:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319342AbSHNVJk>; Wed, 14 Aug 2002 17:09:40 -0400
Message-ID: <3D5AC7F3.1040407@zytor.com>
Date: Wed, 14 Aug 2002 14:13:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com> <20020814204556.GA7440@alpha.home.local> <3D5AC481.2080505@zytor.com> <20020814211140.GB7445@alpha.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
>>>
>>
>>#define __nop() asm volatile("")
> 
> and if you want to pass arguments, to guarantee that no optimization will
> be done, even on loop constants ?
> eg:
>   for (i = 0; i < N; i++) {
>     j++;
>     __nop();
>   }
> 
> -> might be optimized this way :
>   j = N;
>   for (i = 0; i < N; i++) {
>     __nop();
>   }
> 
> Perhaps using a volatile for j ?
> 

OK, what are you trying to accomplish by this?

But if you wanted to, you could do:

for ( i = 0 ; i < N ; i++ ) {
	j++;
	asm volatile("" : "=g" (j));
}


