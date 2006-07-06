Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWGFOlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWGFOlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWGFOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:41:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:55183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030294AbWGFOlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:41:09 -0400
X-Authenticated: #704063
Date: Thu, 6 Jul 2006 16:41:06 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>,
       Henk Vergonet <Henk.Vergonet@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
Message-ID: <20060706144106.GA8764@alice>
References: <1151448080.16217.3.camel@alice> <d120d5000607050655o44cb66c3s7616493c7507d4d8@mail.gmail.com> <20060706004911.GA3563@alice> <200607052225.33352.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607052225.33352.dtor@insightbb.com>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17 (i686)
X-Uptime: 16:39:57 up  5:22,  3 users,  load average: 0.35, 0.44, 0.35
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov (dtor@insightbb.com) wrote:
> On Wednesday 05 July 2006 20:49, Eric Sesterhenn / Snakebyte wrote:
> > I looked at this code several times too, and tried to reproduce the bug
> > with the following little program:
> > 
> > #include <string.h>
> > int main(int argc, char **argv) {
> > 	char foo[] = "abcdef";
> > 	int i = 0;
> > 
> > 	foo[strlen(foo)] = 'X';
> > 	do {
> > 		putchar(foo[i]);
> > 	} while (++i < sizeof(foo));
> > }
> > 
> > Which clearly shows that the terminating '\0' gets printed too,
> > replaced by the X for better visibility, so the code
> > runs past the array, or did I fail to replicate the original
> > code somewhere?
> > 
> 
> What do you mean "the code runs past the array"? The size of array is 7
> (compiler allocates the space for terminating '\0') and the array is
> printed in its entirety.

arg, of course \0 is part of the array, sorry bothering you guys
with this stuff :( Another coverity report i analyzed incorrect... :(

Eric
