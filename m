Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbTFNTcG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 15:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbTFNTcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 15:32:06 -0400
Received: from CPE-65-29-137-188.wi.rr.com ([65.29.137.188]:60658 "EHLO
	supa.0xd6.org") by vger.kernel.org with ESMTP id S265706AbTFNTcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 15:32:04 -0400
Date: Sat, 14 Jun 2003 14:45:12 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SH Port - Makefile
Message-ID: <20030614194510.GD2216@linux-sh.org>
References: <20030614193055.GA3673@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614193055.GA3673@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 09:30:55PM +0200, Sam Ravnborg wrote:
> From arch/sh/Makefile:
> # We don't necessarily agree with the top-level Makefile with regards to what
> # does and does not qualify as a noconfig_targets rule. In this case, we're
> # still dependant on .config settings in order for core-y (machdir-y in
> # particular) to resolve the proper directory. So we just manually include it
> # if it hasn't been already..
> #
> ifndef include_config
> -include .config
> endif
> 
> Could you elaborate a bit more about this.
> I cannot see why core-y is really needed for any noconfig_targets.
> Note that "make clean" do not need to descend in all directories to
> delete .o files, a find is used for that.
> 
Okay, the main reason why I needed to do this was so that a make clean
would get the proper directory path. The problem was that machdir-y
wasn't getting the board name correctly since at make clean time the
CONFIG_SH_xxx names weren't being resolved.

Thus, in the case of:

core-y                          += arch/sh/boards/$(machdir-y)/

make clean was only getting arch/sh/boards/, which doesn't have a
Makefile in it, which resulted in an error when doing the clean.

I'll admit I haven't spent much time investigating this further and just
used the .config include as a quick workaround, so if there's a better
solution for this, I'll gladly adopt it.

> 
> target_links
> Will it be possible for SH to implement the scheme used for i386 instead.
> We have one symlink today, and I like to keep it down on that level.
> 
I haven't looked at the i386 code for this yet, I'll look into this.

> arch/sh/tools
> Something not yet merged?
> 
Not merged yet, will be shortly. I just wanted to get the board stuff
out of the way.

> BOOTIMAGE
> No need to define a variable and then only use it once.
> 
Thanks for catching this, I'll clean that up.

