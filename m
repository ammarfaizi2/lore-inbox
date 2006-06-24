Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWFXB7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWFXB7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFXB7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:59:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:15284 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750829AbWFXB7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:59:44 -0400
Message-ID: <449C9C6D.7050905@zytor.com>
Date: Fri, 23 Jun 2006 18:59:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
Subject: Re: i386 ABI and the stack
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com> <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> We always have. It's the x86 ABI.
> 
> The x86-64 ABI has a 128-byte(*) zone that is safe from signals etc, so 
> you can use a small amount of stack below the stackpointer safely. Not so 
> on x86.
> 
> 		Linus
> 
> (*) That "128 byte" is from memory. Maybe it's bigger.

Adding a small redzone like this to i386 would be easy, though -- just 
drop the stack pointer by that much when creating a signal frame.  128 
bytes isn't enough to interfere with libraries.

Unlike other enhancements that have been proposed to the i386 ABI (like 
regparm), this has the advantage of being fully backwards-compatible 
with old binaries and libraries.  As long as you have a kernel that 
knows to preserve the redzone, then you can use the new -mredzone 
option, but you cross-call classical ABI functions without any problems, 
and old ABI programs won't even notice.

	-hpa
