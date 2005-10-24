Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVJXNm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVJXNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVJXNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:42:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5064 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751022AbVJXNmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:42:25 -0400
Subject: Re: terminal handling: collecting inter-keystroke timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Travis H." <solinym@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d4f1333a0510240046s18021c3exe61ad783ddff0778@mail.gmail.com>
References: <d4f1333a0510232356v1778fb10s186af3979aa323db@mail.gmail.com>
	 <d4f1333a0510240046s18021c3exe61ad783ddff0778@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Oct 2005 15:11:19 +0100
Message-Id: <1130163079.12873.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-24 at 02:46 -0500, Travis H. wrote:
> Ideally any mechanism would be flexible enough that I could have it
> deliver me timings between key-down, key-up-to-key-down, or up/down to
> up/down timings.  And it should be efficient enough that it can
> deliver most of them unprocessed to some userland collector daemon
> which does the filtering of outliers and whatnot.

The keyboard layer abstracts out up/down events, repeat key
functionality and extensions in the normal case. You can put the
keyboard into raw mode and do the work yourself (X does this) and then
feed the results to an application using a pseudo-terminal (see man
openpty).

For networks you are somewhat screwed as the network protocols have
their own timing info and most (telnet, ssh etc) don't pass key up/down
info and batch characters when appropriate. X events might be usable
this way.

> Since I'm on the subject, a related project I had in mind would be
> hacking the keyboard to do its raster-scan in a pseudo-random order
> that was synchronized with the terminal driver such that the signal on
> the wire was, if not encrypted, at least scrambled enough to be
> difficult to convert back into plaintext.  What would this involve on
> the kernel side?

Write a new keyboard driver for the new keyboard you've built. PC
hardware can't do it but we already support keyboard drivers for a
variety of devices and PDAs which are different to the PC world.

