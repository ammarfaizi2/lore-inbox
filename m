Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSIWTLG>; Mon, 23 Sep 2002 15:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSIWTKI>; Mon, 23 Sep 2002 15:10:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261312AbSIWSlp>;
	Mon, 23 Sep 2002 14:41:45 -0400
Date: Mon, 23 Sep 2002 11:35:01 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
Message-ID: <2492970816.1032802501@aslan.btc.adaptec.com>
In-Reply-To: <Pine.LNX.4.44.0209231227330.922-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44.0209231227330.922-100000@freak.distro.conectiva>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin,
> 
> I guess is the second or third report of problems with the new aic7xxx :(

This issue has already been resolved as a chipset issue requiring
I/O mapped register access to work around.  The "old" aic7xxx driver
avoids these issues by issuing a register read after every register
write.  This stops up your PCI bus with wasted cycles even if you have
a perfectly working chipset.

So, how would you like me to resolve this.  We can do the same thing
as Adaptec's windows drivers and just always use the slower, less
efficient I/O mapped method for accessing registers.  This will "fix"
the problems people have with broken VIA and Intel chipsets.  I can
make this a compile and run-time option, but should we default to
I/O mapped or memory mapped?

Don't you just love broken PC hardware?

--
Justin
