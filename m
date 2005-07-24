Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVGXJio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVGXJio (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVGXJin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 05:38:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:22475 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261864AbVGXJim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 05:38:42 -0400
Date: Sun, 24 Jul 2005 11:39:52 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Bodo Eggert <7eggert@gmx.de>, perex@suse.cz, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP
 && ISA
In-Reply-To: <20050723164801.GE3160@stusta.de>
Message-ID: <Pine.LNX.4.58.0507241112150.5658@be1.lrz>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de>
 <Pine.LNX.4.58.0507192232230.4182@be1.lrz> <20050723164801.GE3160@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005, Adrian Bunk wrote:
> On Tue, Jul 19, 2005 at 10:50:53PM +0200, Bodo Eggert wrote:

> > OTOH, the build system
> > should automatically propagate the dependencies. I asume that should be
> > easy, except for having the time to implement that.
> >...
> 
> There are nontrivial problems:
> E.g. what should happen if you select option A that depends on (B || C)?

You should in effect depend on ($original_depends) && (B || C). You'll 
just need to append all (recursive) dependencies in the selecting option.


last_length:=-1; /* impossible value */
while |options_with_unresolved_selects| > 0 do begin
	if |options_with_unresolved_selects| == last_length
	then goto circular_recursion_detected;
	last_length:=|options_with_unresolved_selects|;

	for i in options_with_unresolved_selects do begin
		for s in i->unresolved_selects do
			if 0 == |s->unresolved_selects|
			then begin
				add(i->depends, s->depends)
				delete_from(i->unresolved_selects, s)
			end
		if 0 == |i->unresolved_selects|
		then delete_from(options_with_unresolved_selects, i);
	end
end

> There's one opinion that options should be either select'able _or_ user 
> visible.

That would only result in ugly workarounds. Think about the kernel 
libraries. You'll want to manually select them, and you'll want to 
automatically select them, and you want both to be visible.

-- 
Funny quotes:
22. When everything's going your way, you're in the wrong lane and and going
    the wrong way.
