Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266778AbUHIRZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbUHIRZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHIRZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:25:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:21188 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266778AbUHIRZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:25:05 -0400
Date: Mon, 9 Aug 2004 10:24:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jonathan Corbet <corbet@lwn.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races 
In-Reply-To: <20040809165012.25562.qmail@lwn.net>
Message-ID: <Pine.LNX.4.58.0408091020440.1832@ppc970.osdl.org>
References: <20040809165012.25562.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Aug 2004, Jonathan Corbet wrote:
> 
> This (along with the bits which have just gone into BK) hints at a
> driver API change.  Inquiring minds are *very* curious about such things
> at the moment...  will there be a file_operations method prototype
> change associated with the file offset fixes?

No, it's all just building up to the kernel internally always using a 
pread/pwrite-like thing to the drivers, and then maintaining f_pos 
entirely in the VFS layer. All the VFS interfaces do this already (since 
that is how the user-visible pread/pwrite works).

But a few drivers are buggy (they access f_pos directly even if it was a
user-level pread/pwrite), and in particular the /proc sysctl interface was
totally broken this way.

So I've fixed the sysctl code - that _did_ require a prototype change, but 
wasn't horribly painful, and am going through drivers..

		Linus
