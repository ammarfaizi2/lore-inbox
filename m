Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTDMXeK (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDMXeK (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:34:10 -0400
Received: from dp.samba.org ([66.70.73.150]:38814 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262683AbTDMXeH (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 19:34:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16025.63003.968553.194791@nanango.paulus.ozlabs.org>
Date: Mon, 14 Apr 2003 09:43:23 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <1050243002.24186.7.camel@dhcp22.swansea.linux.org.uk>
References: <200304131306.h3DD6XQ3001331@callisto.of.borg>
	<1050243002.24186.7.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> This looks the wrong place to fix this problem Geert. The PPC 
> folks have the same issues with byte order on busses but you
> won't see ifdefs in the core IDE code for it.
> 
> Fix your __ide_mm_insw/ide_mm_outsw macros and the rest happens
> automatically.

As I understand it, on some platforms (including some PPC platforms,
but not powermacs) one needs to byteswap drive ID data but not the
normal sector data.  Or vice versa.  Whether drive ID data needs
byte-swapping comes down to how the drive is attached to the bus.  The
conventions used by other systems that we need to interoperate with
(e.g. other OSes, or just older kernels) determine whether normal
sector data needs byte-swapping or not.

Since __ide_mm_insw doesn't get told whether it is transferring normal
sector data or drive ID data, it can't necessarily do the right thing
in both situations.

It's very possible that there are some PPC platforms for which IDE is
borken right now - I strongly suspect this would be the case for the
Tivo at least, and probably several other embedded PPC platforms.

Paul.
