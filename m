Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUBPWEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbUBPWEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:04:01 -0500
Received: from mail.shareable.org ([81.29.64.88]:27268 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265913AbUBPWD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:03:59 -0500
Date: Mon, 16 Feb 2004 22:03:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: stty utf8
Message-ID: <20040216220356.GC18853@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216150501.GC16658@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040216150501.GC16658@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Why not create "stty utf8" so that non-UTF-8 terminals and UTF-8
> terminals alike can work with a Linux convention that all programs
> enter and display UTF-8?  It would simplify a lot of things.

I little thought and an experiment later, and I discovered:

When you edit a line with the kernel's terminal line editor, when you
press the Delete key, it writes backspace-space-backspace and removes
one byte from the input.  That fails to do the right thing on UTF-8
terminals.

For example, in a UTF-8 xterm or Gnome terminal, or even on the Linux
console after running "unicode_start", run the command "cat" by
itself, then type "ייי", then hit DEL twice - it will show one
accented letter(*).  Press enter, and cat will echo the line
containing _two_ letters.

There is no fancy environment setting which corrects this problem.
The kernel needs to know it's dealing with a UTF-8 terminal for basic
line editing to work.

(*) The text in quotes is three E WITH ACUTE letters, in case that
doesn't show properly in your mailer.

-- Jamie
