Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319347AbSHNVJ1>; Wed, 14 Aug 2002 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319342AbSHNVIQ>; Wed, 14 Aug 2002 17:08:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12042 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S319315AbSHNVHt>;
	Wed, 14 Aug 2002 17:07:49 -0400
Date: Wed, 14 Aug 2002 23:11:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Willy Tarreau <willy@w.ods.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020814211140.GB7445@alpha.home.local>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com> <20020814204556.GA7440@alpha.home.local> <3D5AC481.2080505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5AC481.2080505@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 01:58:41PM -0700, H. Peter Anvin wrote:
> Willy Tarreau wrote:
> > This way, some loops could be optimized, and the developpers could explicitely
> > tell the compiler when they need to prevent any optimization.
> > 
> 
> #define __nop() asm volatile("")

and if you want to pass arguments, to guarantee that no optimization will
be done, even on loop constants ?
eg:
  for (i = 0; i < N; i++) {
    j++;
    __nop();
  }

-> might be optimized this way :
  j = N;
  for (i = 0; i < N; i++) {
    __nop();
  }

Perhaps using a volatile for j ?

Cheers,
Willy
 
