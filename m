Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277386AbRJEQTM>; Fri, 5 Oct 2001 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277436AbRJEQTD>; Fri, 5 Oct 2001 12:19:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42463 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277386AbRJEQSo>;
	Fri, 5 Oct 2001 12:18:44 -0400
Date: Fri, 5 Oct 2001 12:19:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: lkv@isg.de
cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <3BBDD37D.56D7B359@isg.de>
Message-ID: <Pine.GSO.4.21.0110051214070.2267-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Oct 2001 lkv@isg.de wrote:

> A somewhat bizarre solution would be to have the process create
> a pipe-pair, select on the reading end, and let the signal-handler
> write a byte to the pipe - but this has at least the drawback
> you always spoil one "select-cycle" for each signal you get - as
> the first return from the select() call happenes without any
> fds being flagged as readable, only when you enter select() once
> more the pipe will cause the return and tell you what happened...
 
fork() is cheap.  Create a child, have a pipe between child and
parent and do select() on the other end of pipe.  I.e. signal handler
writes into pipe and that triggers select() in the second process.

