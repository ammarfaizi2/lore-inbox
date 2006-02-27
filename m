Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWB0Tdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWB0Tdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWB0Tdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:33:39 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:24127 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751745AbWB0Tdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:33:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VnsFckcLVspVVvp5Omqj/0Hj55+QqfhZj4vOycAYS1KTz8Ls6STz2BTMOr+3C2kM9/L4zwC+oYVDG6cNONTcHTcsxxU6Z9Ofg89lZHv2S9qOVdHoV4Y6FFHtJwDEaCbP96Qf5JuUsXUMKgLEfgyduz0jX1uVp/F6CPGCRiZYpyU=
Message-ID: <9a8748490602271133o4aa673e4x3c069c1ab08fc392@mail.gmail.com>
Date: Mon, 27 Feb 2006 20:33:38 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: Question regarding call trace.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602271411020.5678@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602271411020.5678@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> I have a trace that looks like the following, my question is, are the
> process(es) at the top of the call trace responible for the actual crash
> of the machine?  Are they the root cause?
>

As a general rule, functions near the top of a trace are more likely
to be the cause of the crash than functions near the bottom, but
that's not always the case.
Also sometimes when dealing with race conditions some part of the
kernel messes up and causes a different part of the kernel to crase so
that what you see in the trace is not what actually *caused* the
problem but merely what was affected by a problem somewhere else.
And if there's memory corruption going on then sometimes one part of
the kernel can scrible on random memory and cause a different and
completely unrelated part of the kernel to blow up.
So you cannot always trust a call trace 100%.


> Would this point to a bad SCSI board?
>
I'm sorry, I can't tell you :(

You might want to try enable debugging symbols and frame pointers to
get a more readable trace.

Consider these options (in the Kernel Hacking section of menuconfig) :
  CONFIG_DEBUG_KERNEL
  CONFIG_DEBUG_INFO
  CONFIG_FRAME_POINTER
  CONFIG_UNWIND_INFO

There are other options in there as well that may help, read their
description and decide for yourself if you think they will be needed -
or maybe someone else who understands your dump better than me can
advice on what specific options to enable.

Hope this helps you.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
