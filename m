Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVAYPfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVAYPfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVAYPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:35:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:4501 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261986AbVAYPfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:35:05 -0500
Date: Tue, 25 Jan 2005 16:34:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pavel Fedin <sonic_amiga@rambler.ru>
cc: Alex Riesen <raa.lkml@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Russian encoding support for MacHFS
In-Reply-To: <20050125123516.7f40a397.sonic_amiga@rambler.ru>
Message-ID: <Pine.LNX.4.61.0501251545540.6118@scrub.home>
References: <20050124125756.60c5ae01.sonic_amiga@rambler.ru>
 <81b0412b05012410463c7fd842@mail.gmail.com> <20050125123516.7f40a397.sonic_amiga@rambler.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 25 Jan 2005, Pavel Fedin wrote:

> > how about just leave the characters unchanged? (remap them to the same
> > codes in Unicode).
> 
>  But what to do when i convert then from unicode to 8-bit iocharset? 
> This can lead to that several characters in Mac charset will be 
> converted to the same character in Linux charset. This will lead to 
> information loss and name will not be reverse-translatable.
>  To describe the thing better: i have 8-bit Mac encoding and 8-bit 
> target encoding (iocharset). I need to convert from (1) to (2) and be 
> able to convert back. I tried to perform a one-way conversion like in 
> other filesystems but this didn't work.
>  Probably NLS tables can be used when iocharset is UTF8. If you wish i 
> can try to implement it after some time.

I'm not quite sure, what problem you're trying to solve here. NLS is used 
to convert from a local encoding to unicode, HFS has only 8bit 
characters, so there isn't much space to store the unicode characters in. 
If you want to use utf-8, you can do so without changing hfs. All 
filesystem which don't use nls (that includes e.g. ext3) store the 
filename in the local encoding.
If you want to store unicode characters use HFS+, I plan to implement nls 
support real soon for it (especially because to also fix the missing 
decomposition support). 

bye, Roman
