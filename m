Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293143AbSBWPNz>; Sat, 23 Feb 2002 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293145AbSBWPNg>; Sat, 23 Feb 2002 10:13:36 -0500
Received: from pD9E10168.dip.t-dialin.net ([217.225.1.104]:32128 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S293143AbSBWPNZ>;
	Sat, 23 Feb 2002 10:13:25 -0500
Date: Sat, 23 Feb 2002 16:13:21 +0100
From: Felix von Leitner <usenet-20020223@fefe.de>
To: Dan Aloni <da-x@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020223151321.GH301@fefe.de>
Mail-Followup-To: Dan Aloni <da-x@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Dan Aloni (da-x@gmx.net):
> The attached patch implements C exceptions in the kernel, which *don't*
> depend on special support from the compiler. This is a 'request for
> comments'. The patch is very initial, should not be applied.

First of all: setjmp/longjmp is quite inefficient.

But my real problem with this is that the point about exceptions in C++
is the automatic stack unwinding.  You use local variables and if an
exception is thrown, they automatically self-destruct.  In particular,
you could implement spin locks as a class, and an exception will release
the lock automatically.  Since this is not there in C, this is no more
elegant than using explicit goto.

Also, it makes understanding the code (and correlating assembly output
with C code) less easy, because you also have to look at that exception
implementation.

Felix
