Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWHXRQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWHXRQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWHXRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:16:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17320 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030406AbWHXRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:16:33 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060824170709.GO19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com>
	 <20060824152937.GK19810@stusta.de>
	 <1156434274.3012.128.camel@pmac.infradead.org>
	 <20060824155814.GL19810@stusta.de>
	 <1156435216.3012.130.camel@pmac.infradead.org>
	 <20060824160926.GM19810@stusta.de>
	 <20060824164752.GC5205@martell.zuzino.mipt.ru>
	 <20060824170709.GO19810@stusta.de>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:16:03 +0100
Message-Id: <1156439763.3012.155.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 19:07 +0200, Adrian Bunk wrote:
> Do a "make menuconfig" and look at the number of options.

Why would I do that? I haven't done that for _years_. I've just edited
the .config file, removed the line which turns some option on or off,
then run 'make oldconfig'. I get asked about the option in question, and
then if I've turned something on I get asked about other options which
depend on it and which are now possible but weren't before.

Increasingly, these days, that approach has been failing due to all this
Aunt Tillie crap. I tried turning off CONFIG_KALLSYMS the other day, but
it took me a while to work out how. And the increasing use of 'select'
is even worse.

> There's e.g. no reason to ask all users whether they want to compile all 
> I/O schedulers into their kernel.
> 
> To avoid misunderstandings:
> 
> I'm not talking about people subscribed to this list.
> 
> It's more about a system administrator who must for some reason (e.g. 
> hardware support or the requirement of some external patch) compile his 
> own kernel.

Why on earth would they create a config file from scratch instead of
using a defconfig or the config from their distribution and modifying it
so suit their needs?

For most things, they ought to be able to just build extra modules to
_match_ their distribution's kernel, without having to rebuild the
kernel itself. (Although people doing stupid things in the kernel like
#ifdef CONFIG_foo_MODULE tends to screw them sometimes -- I can't build
IPv6 for my Nokia 770 without replacing its kernel, for example).

People just don't have that much cause to create configs from scratch --
there's little benefit in pandering to those who are less able. Make the
_defaults_ sane, by all means -- but don't just start hiding options.

However you dress it up, it's still ESR's Aunt Tillie come to haunt us.
And it's a PITA.

-- 
dwmw2

