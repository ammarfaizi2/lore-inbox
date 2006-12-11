Return-Path: <linux-kernel-owner+w=401wt.eu-S937132AbWLKQeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937132AbWLKQeZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937135AbWLKQeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:34:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41515 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937132AbWLKQeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:34:23 -0500
Date: Mon, 11 Dec 2006 08:34:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Akinobu Mita <akinobu.mita@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const 
In-Reply-To: <29623.1165853572@redhat.com>
Message-ID: <Pine.LNX.4.64.0612110831010.12500@woody.osdl.org>
References: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org> 
 <29447.1165840536@redhat.com>  <29623.1165853572@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, David Howells wrote:
> 
> Ah.  I thought that was just for supporting old versions of gcc.  I didn't
> realise it was for handling strange compilers.

I'm not sure how much (if at all) the Intel compiler is actually used, and 
for all I know it may even support __attribute__((__const__)) these days, 
but I like the notion of allowing us to support other compilers, so the 
infrastructure is all set up for that.

The main <linux/compiler.h> thing includes various per-compiler headers, 
and then defaults some things to be empty if the compiler-specific header 
doesn't have its own #define for it. So it's actually set up to try to 
help more than just gcc or the Intel compiler, although nobody has done 
anything else afaik.

I think all versions of gcc support the __attribute__((const)) thing (and 
indeed, it's in the "generic" gcc header file, not the per-gcc-version 
one).

		Linus
