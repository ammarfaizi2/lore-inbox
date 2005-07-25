Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVGYVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVGYVWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGYVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261389AbVGYVVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:21:48 -0400
Date: Mon, 25 Jul 2005 14:21:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rodrigo Ramos <rodrigo.ramos@triforsec.com.br>
cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       haible@ma2s2.mathematik.uni-karlsruhe.de, bradh@frogmouth.net,
       orc@pell.chi.il.us, jrs@world.std.com, linux-kernel@vger.kernel.org
Subject: Re: data + pendrive + memory
In-Reply-To: <1122321721.2817.75.camel@ZeroOne>
Message-ID: <Pine.LNX.4.58.0507251418030.6074@g5.osdl.org>
References: <1122321721.2817.75.camel@ZeroOne>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jul 2005, Rodrigo Ramos wrote:
> 
> IMHO, if a lack of memory happens the Linux will start using swap, then
> the file will end in the hard drive. When I am working with a file in a
> pendrive any information of it is sent to the hard drive ? If it happens
> what is/are the reason(s).

If you always access the file only with mmap(..MAP_SHARED..) (or
MAP_PRIVATE in a read-only manner), or if you always make sure that any
programs that access the data use mlock() to protect it, you'll never hit
the regular disk.

mmap() is generally the better option, since locking down memory may not
be available to normal users.

		Linus
