Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbTJSRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTJSRh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:37:28 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:20232 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262006AbTJSRhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:37:15 -0400
Date: Sun, 19 Oct 2003 19:37:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031019173713.GA1776@mars.ravnborg.org>
Mail-Followup-To: Ingo Oeser <ioe-lkml@rameria.de>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
References: <20031015225055.GS17986@fs.tum.de.suse.lists.linux.kernel> <20031018105733.380ea8d2.akpm@osdl.org.suse.lists.linux.kernel> <p731xtapd4r.fsf@oldwotan.suse.de> <200310191556.56469.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310191556.56469.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 03:56:56PM +0200, Ingo Oeser wrote:
> Maybe there should be sth. in the build system for that, which is called
> $(call optimize_for_speed, $target) and $(call optimize_for_size,$target) 
> which then can be added on a per file basis and per directory tree,
> where it really matters and letting it to the default otherwise.
> 
> That way we can tune gradually and remove GCC options.
> 
> Simple implementation today:
> 
> optimize_for_speed := CFLAGS_$1 += -O3
> optimize_for_size  := CFLAGS_$1 += -Os
> 
> 
> Sam: What do you think?

Focussing on -O2 versus -Os is too narrowscoped for the build system.
A much more general solution is needed, without loosing the flexibility
we have today.
For 2.7 I have planned making it possible to modify CFLAGS, and make the
change be effective for all recursive builds.
This could be usefull if for example acpi decides to use -Werror for
all files. One change in one makefile and the desired effect is achieved.
The same infrastructure will be possible to use for -Owhatever.

We sould stick with -O2 for 2.6, lets play with other settings for 2.7.
Router people and others with special needs can finetune it at will in
2.6 - it is one line in the top-level makefile so not a big deal.

	Sam
