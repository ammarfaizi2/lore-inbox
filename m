Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTBHWJH>; Sat, 8 Feb 2003 17:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTBHWJH>; Sat, 8 Feb 2003 17:09:07 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:51584 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S267121AbTBHWJH>;
	Sat, 8 Feb 2003 17:09:07 -0500
Date: Sat, 8 Feb 2003 23:18:44 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Thomas Molina <tmolina@cox.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 328] New: The computer seems to hang after the kernel has uncompressed and starts to boot.
Message-ID: <20030208221844.GA3206@win.tue.nl>
References: <20980000.1044736584@[10.10.2.4]> <Pine.LNX.4.44.0302081456180.3031-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302081456180.3031-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2003 at 03:00:43PM -0600, Thomas Molina wrote:

> I began to see this bug this weekend myself.  I'm not sure of the cause, 
> but it can be worked around by configuring the kernel for built-in (not 
> modular) support of virtual terminals (CONFIG_VT) and support for console 
> on virtual terminals (CONFIG_VT_CONSOLE).  

Maybe unrelated, but there is some really ugly code in
char_dev.c:get_chrfops().

There, if one needs a character device that is not present
a request_module("char-major-%d") is done.
However, if the character device has TTY_MAJOR or TTYAUX_MAJOR
and a driver for this major is requested, and we already have
one, but it is the wrong one, then we also do the request_module.
Yecch.

The reason is of course that entirely different drivers cover
different fragments of the major space (4,1 is /dev/tty1 and
4,65 is /dev/ttyS1)

So, I could imagine that if one has neither module, and needs
one, get_chrfops() loads the wrong one. Speculation.

Andries
