Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUA0CJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUA0CJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:09:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:10196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262040AbUA0CJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:09:28 -0500
Date: Mon, 26 Jan 2004 18:09:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: gotom@debian.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] refuse plain ufs mount
In-Reply-To: <UTC200401270156.i0R1uiR06609.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0401261805590.10794@home.osdl.org>
References: <UTC200401270156.i0R1uiR06609.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004 Andries.Brouwer@cwi.nl wrote:
> 
> But you see, it wasn't the user at all, and it wasn't a ufs filesystem.
> It is kernel probing that causes error messages. That is unwanted.
> So, your version is wrong.

Yes. 

However, I think the _real_ bug is that we have reiserfs near the tail of 
filesystems to try.

The filesystems in fs/Makefile are listed in order of being probed, so I 
really thing the real fix is to ignore the whole verbose thing entirely,
and just move reiserfs upwards.

Because if you actually get far enough that you try to mount UFS as your
root filesystem, you have other problems, and verbosity at boot is not
your real issue.

Can you test that alternate patch instead? 

		Linus
