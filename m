Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRGPBxZ>; Sun, 15 Jul 2001 21:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265887AbRGPBxP>; Sun, 15 Jul 2001 21:53:15 -0400
Received: from [192.48.153.1] ([192.48.153.1]:33599 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S265844AbRGPBxA>;
	Sun, 15 Jul 2001 21:53:00 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Gareth Hughes <gareth.hughes@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3) 
In-Reply-To: Your message of "Mon, 16 Jul 2001 11:29:47 +1000."
             <3B52438B.3CC6E1BC@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Jul 2001 11:51:58 +1000
Message-ID: <22193.995248318@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001 11:29:47 +1000, 
Gareth Hughes <gareth.hughes@acm.org> wrote:
>Plus, there were symbol clashing problems with building some drivers
>into the kernel and some as modules.  Keith Owens could comment on
>that.  The new code avoids this problem as well.

The clash occurred when two DRM objects were linked into the kernel, it
resulted in two copies of the DRM code in vmlinux and ld spat the
dummy.  I did a workaround in drivers/char/drm/Makefile for the old
code so that problem does not exist any more.

But even with that workaround, if one DRM object is a module and
another is built in, the code in drmlib.a sometimes gets compiled for a
module and sometimes for built in.  AFAIK this does not cause any
problems but is ugly.  Come to that, the entire drm/Makefile is ugly.

Note that these problems are not caused by code vs. macros, they are a
direct effect of the insistence that each DRM object has its own set of
routines instead of sharing common code.  Using macros removes drmlib
but still propagates the idea of not sharing code.  As long as it does
not get in the way of kbuild then I am happy, others may disagree about
the approach.

