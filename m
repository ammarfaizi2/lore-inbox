Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUCOR6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbUCOR6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:58:19 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:30785 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262147AbUCOR6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:58:17 -0500
Date: Mon, 15 Mar 2004 18:58:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] out-of-tree builds
Message-ID: <20040315175850.GA8456@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be> <Pine.GSO.4.58.0403151337120.14245@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403151337120.14245@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 01:41:02PM +0100, Geert Uytterhoeven wrote:
> 
> Unfortunately not everything works.
> 
> E.g. I need to build usr/ with a different (newer) binutils, so when the build
> fails on assembling usr/initramfs_data.o, I used to do the following, which no
> longer works:
> 
> | tux$ PATH=/usr/bin/:$PATH make usr/
> | make: `usr/' is up to date.
> | tux$
> 
> I guess I need a catch-all .PHONY rule, but don't know how to implement it...

Try:
.PHONY: $(MAKECMDGOALS)

or eventually
ifneq ($(MAKECMDGOALS),)
.PHONY: $(MAKECMDGOALS)
endif

The latter if an empty .PHONY is not allowed.

	Sam

