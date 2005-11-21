Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVKUKyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVKUKyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVKUKyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:54:09 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:27793 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751013AbVKUKyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:54:08 -0500
Date: Mon, 21 Nov 2005 11:53:53 +0100
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: make kernelrelease ignoring LOCALVERSION_AUTO
Message-ID: <20051121105353.GC6664@informatik.uni-freiburg.de>
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us> <m3mzjy7sg2.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3mzjy7sg2.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Mutt/1.5.6+20040523i
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cloos wrote:
> I did a $(git-repack -a -d && git-prune-packed) before trying the bisect.  
> 
> I also found that $(make oldconfig; make kernelrelease) was enough to
> bisect down to the commit in question.
> 
> The final git bisect bad reported:
> 
> ,---- :; git bisect bad
> | ac4d5f74a9b243d9f3f123fe5ce609478df208d8 is first bad commit
> | diff-tree ac4d5f74a9b243d9f3f123fe5ce609478df208d8 (from ab919c06144cfb11c05b5b5cd291daa96ac2e423)
> | Author: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
> | Date:   Wed Nov 9 15:54:08 2005 +0100
> | 
> |     [PATCH] kbuild: make kernelrelease in unconfigured kernel prints an error
> | 
> |     Do not include .config for target kernelrelease
> | 
> |     Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
> |     Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> | 
> | :100644 100644 2dac8010c14296bf71b20da92d7256d6a5b41f22 3152d6377eb20bb79a95850fabf7b6fee3a64ad2 M      Makefile
> `----
>
> Whatever the solution, it is commit ac4d5f74a9b243d9f3f123fe5ce609478df208d8
> that breaks $(make kernelrelease).
That's true, I recently realized that, too, but didn't find the time to
react.

In my eyes the solution has to be that .config is included iff it
exists.

I'll work out a patch and send it to you.

Best regards
Uwe

-- 
Uwe Zeisberger

exit vi, lesson V:
o : q ! CTRL-V <CR> <Esc> " d d d @ d
