Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317890AbSGQD2w>; Tue, 16 Jul 2002 23:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSGQD2v>; Tue, 16 Jul 2002 23:28:51 -0400
Received: from mail.eskimo.com ([204.122.16.4]:35856 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S317890AbSGQD2v>;
	Tue, 16 Jul 2002 23:28:51 -0400
Date: Tue, 16 Jul 2002 20:31:02 -0700
To: Thunder from the hill <thunder@ngforever.de>
Cc: Elladan <elladan@eskimo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717033102.GA31286@eskimo.com>
References: <20020717030043.GA31110@eskimo.com> <Pine.LNX.4.44.0207162108480.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207162108480.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 09:10:49PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Tue, 16 Jul 2002, Elladan wrote:
> > > Thread 2 shouldn't be able to reuse a currently open fd. This application 
> > > design is seriously broken.
> 
> Okay, again. It's about doing a second close() in case the first one fails 
> with EAGAIN. If we have to do it again, the filehandle is not closed, and 
> if the filehandle is not closed, the kernel knows that, and if the kernel 
> knows that the filehandle is still open, it won't get reassigned. Problem 
> gone.

This is case 2, "Close is guaranteed to leave the file open on error."

In this case, all applications are required to reissue close commands
upon certain errors, or leak a file descriptor.  This would be a well
defined behavior, though perhaps error prone.

However, note that this is manifestly different from case 1, "Close is
guaranteed to close the file the first time."  If the system behaves via
case 1, closing the handle again is broken as the example illustrated.

The worst, of course, would be undefined behavior for close.  In this
case, the application effectively can't do the right thing without
extreme measures.

-J
