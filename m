Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUDSF2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 01:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUDSF2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 01:28:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:58014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbUDSF2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 01:28:16 -0400
Date: Sun, 18 Apr 2004 22:28:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Nasty 2.6 sendfile() bug / regression; affects vsftpd
In-Reply-To: <20040419004657.GD11064@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0404182220470.2808@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
 <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org> <20040419004657.GD11064@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Apr 2004, Jamie Lokier wrote:
> 
> Is there a reason why put_user() supports 1/2/4/8 bytes and get_user()
> supports only 1/2/4 bytes?

It's a bit more complicated to do get_user, mainly because we use a 64-bit
value to pass the data around already on x86 - the "real data" in %eax,
and the error code in %edx. So you'd need to have a slightly different 
calling convention for the 8-byte case, so it was more than just 
"duplicate the other cases".

I agree that it's an ugly special case. get/put_user should really accept 
all the normal cases, and that includes 'u64'.

Not a lot of code cares, though, so for now we've just had the special 
case. You are the first one to notice, I think.

		Linus
