Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVBQNgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVBQNgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVBQNgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:36:04 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35210 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261790AbVBQNf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:35:58 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Thu, 17 Feb 2005 08:35:35 -0500
User-Agent: KMail/1.7.92
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200502170348.j1H3mVpV008827@laptop11.inf.utfsm.cl>
In-Reply-To: <200502170348.j1H3mVpV008827@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502170835.35623.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 10:48 pm, Horst von Brand wrote:
> Does x86_64 use up a (freeable) register for the frame pointer or not?
> I.e., does -fomit-frame-pointer have any effect on the generated code?

{Took Linus out of the loop as he probably isn't interested}

The generated code is different for both cases but for some reason gcc has 
trouble with __builtin_return_address on x86-64.

For e.g. specifying gcc -fo-f-p, a method produces following assembly.

method_1:
.LFB2:
        subq    $8, %rsp
.LCFI0:
        movl    $__FUNCTION__.0, %esi
        movl    $.LC0, %edi
        movl    $0, %eax
        call    printf
        movl    $0, %eax
        addq    $8, %rsp
        ret

And with -fno-o-f-p,  the same method yields 

method_1:
.LFB2:
        pushq   %rbp
.LCFI0:
        movq    %rsp, %rbp
.LCFI1:
        movl    $__FUNCTION__.0, %esi
        movl    $.LC0, %edi
        movl    $0, %eax
        call    printf
        movl    $0, %eax
        leave
        ret
