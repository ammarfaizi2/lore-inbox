Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSHXMco>; Sat, 24 Aug 2002 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHXMcn>; Sat, 24 Aug 2002 08:32:43 -0400
Received: from dp.samba.org ([66.70.73.150]:30853 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S315928AbSHXMcn>;
	Sat, 24 Aug 2002 08:32:43 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15719.32025.236298.592156@argo.ozlabs.ibm.com>
Date: Sat, 24 Aug 2002 22:33:29 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] cfbimgblt.c
In-Reply-To: <Pine.LNX.4.33.0208221123140.9077-200000@maxwell.earthlink.net>
References: <1029972099.551.3.camel@daplas>
	<Pine.LNX.4.33.0208221123140.9077-200000@maxwell.earthlink.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> Paul please test the code.

(The new cfbimgblt.c, that is.)

It mostly seems to be fine, except there are some problems with the
cursor.  I have only tested it with the standard 8x16 font so far
though.  I had to add a #include <video/fbcon.h> near the top to get
the definitions of fb_readl and fb_writel.

It seems to be not erasing the cursor image when it should.  So, if I
am logged in on the console and I type a few characters and then press
backspace a few times, it leaves those character positions entirely
white.  Also, when I press return it leaves the cursor image on that
line as well as drawing the cursor after the shell prompt on the next
line.

I just tried with the old cfbimgblt.c and it also does the same
thing.  So it's not the new cfbimgblt.c that is doing this, it's
something else in your fbcon changes (or just possibly mine :).  This
is with atyfb with my patches.
Paul.
