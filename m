Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbVKWXMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVKWXMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbVKWXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:12:09 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:1162 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030493AbVKWXMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:12:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lmjTk9xeSfQ3dTbAA5kPW8FycEz3V4uhfYMm6TirerfOqNZpkzorWEmDqO2zjzRW/FMhmVUcusjPIEm5bnqB7YHdP0Btc5K/M18vNTRz+DkMNzvkQLBLG+Kv3pcpOIjnJacyOjCY6PO1UppYCejBVuuSZ30PROQS6gdeMkDq4hM=
Message-ID: <d120d5000511231512n686b8918v65b209863c93cc2a@mail.gmail.com>
Date: Wed, 23 Nov 2005 18:12:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull 09/14] Uinput: add UI_SET_SWBIT ioctl
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1132786887.26560.341.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051120063611.269343000.dtor_core@ameritech.net>
	 <20051120064420.389911000.dtor_core@ameritech.net>
	 <1132786887.26560.341.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Oh,and ... ARGH !
>
> So you pass that nice structure
>
> struct input_event {
>        struct timeval time;
>        __u16 type;
>        __u16 code;
>        __s32 value;
> };
>
> to userland via read() ... cool, a structure that is not compatible
> between 32 and 64 bits passed around via a read call. that will be fun
> to fix.
>

It would need the same treatment as evdev got. Entire uinput is not
32/64 bit friendly (hostorically). However, it should be used by an
userspace "driver", not an ordinary program, so we probably shoudl
just require using native-sized binary with uinput.

--
Dmitry
