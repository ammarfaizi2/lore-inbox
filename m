Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUA3ROK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUA3ROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:14:10 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:45334 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262566AbUA3ROI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:14:08 -0500
Date: Fri, 30 Jan 2004 11:14:07 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Message-ID: <20040130171407.GA18320@hexapodia.org>
References: <20040130152835.GN31589@devserv.devel.redhat.com> <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 11:35:20AM -0500, James Morris wrote:
> -	const u8 padding[64] = { 0x80, };
> +	static u8 padding[64] = { 0x80, };

The RedHat bug suggests 'static const' as the appropriate replacement.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114610#c4

Unfortunately that probably means an extra 64 bytes of text, rather than
the 10 or so bytes of instructions to do the memset and store.  Ideally
padding[] would be allocated in BSS rather than text or the stack (and
initialized with { 0x80, } at runtime), but I guess you can't have
everything.

-andy
