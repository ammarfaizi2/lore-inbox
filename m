Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHAPdT>; Thu, 1 Aug 2002 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSHAPdT>; Thu, 1 Aug 2002 11:33:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9200 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315445AbSHAPdS>; Thu, 1 Aug 2002 11:33:18 -0400
Subject: Re: [PANIC] APM bug with -rc4 and -rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020801152459.GA19989@alpha.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local> <20020801133202.GA200@pcw.home.local>
	<1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
	<20020801135623.GA19879@alpha.home.local> 
	<20020801152459.GA19989@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 17:53:46 +0100
Message-Id: <1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 16:24, Willy Tarreau wrote:
> > Ok, thanks. I'll try to revert some patches from -rc4. But it looks
> > more like a side effect IMHO. Perhaps the APM initialization code
> > triggers one of the numerous bugs in the bios :-/
> 
> It seems that I cannot reproduce it anymore if I revert arch/i386/kernel/vm86.c
> to the state of -rc3. Reverting clear_AC doesn't change anything, but the
> rest of the patch does. I don't know why, it seems correct at first glance.
> Perhaps old code hides a bug in the bios... Well, i don't know, I'm not
> enough aware of apm or vm86 internals to understand what's happening.

Very curious indeed because someone else reported that rc3-ac5 works
(which has the same vm86 code). In addition the vm86 handler in the
kernel isnt actually used for APM. We make 32bit APM calls and the one
16bit case we do is a true return to real mode.

