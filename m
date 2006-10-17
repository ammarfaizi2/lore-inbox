Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWJQP3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWJQP3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWJQP3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:29:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWJQP3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:29:06 -0400
Date: Tue, 17 Oct 2006 08:28:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned 
In-Reply-To: <27543.1161075840@redhat.com>
Message-ID: <Pine.LNX.4.64.0610170825581.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>  <27543.1161075840@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2006, David Howells wrote:

> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > 	* sizeof(*ptr) should be one of 1, 2, 4, 8
> 
> Should we give an error if someone tries passing a 1-byte-sized memory location
> to get/put_unaligned()?  I suspect it might be best to reduce to a trivial
> direct assignment in that case.

Note that in some cases, you have different architectures having different 
sizes, and it could potentially be the case that one architecture has a 
1-byte thing, and another has a 2-byte thing.

It's unlikely to be an issue for single-byte cases, but it definitely 
happens for other equivalent things (ie "get_user()" often has 2 vs 4-byte 
accesses, and obviously the 4- vs 8-byte thing through 32/64-bit values 
depending on the size of the machine).

So at least in _theory_ it's quite possible that a single-byte access can 
make sense, simply because the size might depend on a config option.

		Linus
