Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTDNWVM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTDNWVM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:21:12 -0400
Received: from dp.samba.org ([66.70.73.150]:42473 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264016AbTDNWUm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:20:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16027.14047.217861.806425@nanango.paulus.ozlabs.org>
Date: Tue, 15 Apr 2003 08:31:59 +1000 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <Pine.GSO.4.21.0304142148210.25092-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0304141038430.19302-100000@home.transmeta.com>
	<Pine.GSO.4.21.0304142148210.25092-100000@vervain.sonytel.be>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven writes:

> I think the least-intrusive solution is something like this:
> 
> --- linux-2.5/drivers/ide/ide-iops.c.orig	Mon Apr 14 21:43:30 2003
> +++ linux-2.5/drivers/ide/ide-iops.c	Mon Apr 14 21:44:53 2003
> @@ -423,8 +423,7 @@
>   */
>  void ide_fix_driveid (struct hd_driveid *id)
>  {
> -#ifndef __LITTLE_ENDIAN
> -# ifdef __BIG_ENDIAN
> +    if (ide_driveid_needs_swapping(id)) {

I really think that whether the driveid needs swapping should be
regarded as a property of the interface, not of the system as a whole.

I like the idea of adding a "read in driveid" function pointer to the
ide_hwif_t structure.  Most systems would set that to the same as the
INSW function pointer.  For those systems where the hardware designer
suffered a momentary dizzy spell we can set it to point to a function
that does the necessary byte-swapping.

Paul.
