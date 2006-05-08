Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWEHWGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWEHWGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEHWGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:06:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7891 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751188AbWEHWGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:06:16 -0400
Date: Tue, 9 May 2006 00:06:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] a few small mconf improvements
In-Reply-To: <200605071749.28822.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0605082337280.32445@scrub.home>
References: <200605071749.28822.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 May 2006, Jesper Juhl wrote:

>  - rename main() arguments from "ac"/"av" to the more common "argc"/"argv".

conf.c and qconf.cc do the same, it's a personal preference.

>  - when unlinking lxdialog.scrltmp, the return value of unlink() is not 
>    checked. The patch adds a check of the return value and bails out if 
>    unlink() fails for any reason other than ENOENT.

The check is not needed, the worst that can happen is a misbehaving 
lxdialog and you certainly have bigger problems than this, if the unlink
should fail. In the long term this should go away anyway.

>  - if the sscanf() call in conf() fails and stat==0 && type=='t', then 
>    we'll end up dereferencing a NULL 'sym' in sym_is_choice(). The patch 
>    adds a NULL check of 'sym' to that path and bails out with a big fat 
>    error message if that should ever happen (better than just crashing 
>    IMHO).

That error message is as useful to the normal user as a segfault - mconf 
doesn't work. Since it shouldn't happen, this check adds no real value, 
the user still has to provide enough information to reproduce the problem 
and at this point it makes no difference, whether I get this message or I 
see where it stops with gdb.

bye, Roman
