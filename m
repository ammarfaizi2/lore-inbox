Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWJWRGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWJWRGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWJWRGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:06:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964955AbWJWRGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:06:02 -0400
Date: Mon, 23 Oct 2006 10:05:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andi Kleen <ak@suse.de>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.62.0610231848240.1841@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0610231003240.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
 <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
 <Pine.LNX.4.62.0610231812290.1841@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230928430.3962@g5.osdl.org>
 <Pine.LNX.4.62.0610231848240.1841@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2006, Geert Uytterhoeven wrote:
> 
> I agree _verifying_ this for all config and arch combinations is hard.
> But my point is that right now we're `solving' this at the user (of the
> include) level, which is an order of magnitude more work.
> If the includes were (sufficiently) self-contained, the driver writers would
> have to care less about config/arch dependencies.

But header files already basically are self-contained. They didn't always 
use to be that way, but over the years, we've generally made them that way 
in almost all cases.

The problem is generally not that they aren't self-contained, it's that 
they bring in other things depending on architecture, and then some driver 
depends on a header file including other header files, even when that 
isn't always the case at all: exactly because which header file it 
includes depends on config options (to a small degree) and on architecture 
(to a much larger degree).

		Linus
