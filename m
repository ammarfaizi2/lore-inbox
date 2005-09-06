Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVIFR4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIFR4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVIFR4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:56:47 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:33776 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S1750731AbVIFR4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:56:46 -0400
Date: Tue, 06 Sep 2005 10:54:06 -0700
From: Terrence Miller <Terrence.Miller@Sun.COM>
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" ->
 "static inline"
In-reply-to: <20050905184740.GF7403@devserv.devel.redhat.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Michael Matz <matz@suse.de>, ak@suse.de,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Reply-to: Terrence.Miller@Sun.COM
Message-id: <431DD7BE.7060504@Sun.COM>
Organization: Sun Microsystems
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.4) Gecko/20041214
References: <20050902203123.GT3657@stusta.de>
 <Pine.LNX.4.58.0509051047530.27439@wotan.suse.de>
 <20050905180005.GA3776@stusta.de>
 <20050905184740.GF7403@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Mon, Sep 05, 2005 at 08:00:05PM +0200, Adrian Bunk wrote:
> 
>>It isn't the same, but "static inline" is the correct variant.
>>
>>"extern inline __attribute__((always_inline))" (which is what
>>"extern inline" is expanded to) doesn't make sense.
> 
> 
> It does make sense and is different from
> static inline __attribute__((always_inline)).
> Try:
> static inline __attribute__((always_inline)) void foo (void) {}
> void (*fn)(void) = foo;
> vs.
> extern inline __attribute__((always_inline)) void foo (void) {}
> void (*fn)(void) = foo;
> In the former case, GCC will emit the out of line static copy of foo
> if you take its address, in the latter case either you provide foo
> function by other means, or you get linker error.
> 
> 	Jakub

Another standards complient way of dealing with extern inline is
for every module that requires an address generates its own
global copy and the link_once (or COMDAT) facility is used to eliminate
all but one.

-- 

                              Terrence

        ****************************************************
        | Terrence C. Miller      |  Sun Microsystems      |
        | terrence.miller@Sun.COM |  M.S. MPK16-303        |
        | 650-786-9192            |  16 Network Circle     |
        |                         |  Menlo Park, CA 94025  |
        ****************************************************


