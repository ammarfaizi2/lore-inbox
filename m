Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUA3Ttx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUA3Ttw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:49:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15317 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263946AbUA3Ttv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:49:51 -0500
Date: Fri, 30 Jan 2004 14:49:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Message-ID: <20040130194921.GO31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040130152835.GN31589@devserv.devel.redhat.com> <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com> <20040130171407.GA18320@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130171407.GA18320@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 11:14:07AM -0600, Andy Isaacson wrote:
> On Fri, Jan 30, 2004 at 11:35:20AM -0500, James Morris wrote:
> > -	const u8 padding[64] = { 0x80, };
> > +	static u8 padding[64] = { 0x80, };
> 
> The RedHat bug suggests 'static const' as the appropriate replacement.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114610#c4
> 
> Unfortunately that probably means an extra 64 bytes of text, rather than
> the 10 or so bytes of instructions to do the memset and store.  Ideally
> padding[] would be allocated in BSS rather than text or the stack (and
> initialized with { 0x80, } at runtime), but I guess you can't have
> everything.

Or you can use
	u8 padding[64] = { 0x80 };
if you really want to initialize it at runtime and want to work around the
compiler bug.  It shouldn't be any less efficient than
	const u8 padding[64] = { 0x80 };
since it is used just once, passed to non-inlined function.

	Jakub
