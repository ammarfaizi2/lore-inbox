Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTDWXvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTDWXvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:51:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10253 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264334AbTDWXvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:51:38 -0400
Date: Thu, 24 Apr 2003 02:03:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>, Pavel Machek <pavel@ucw.cz>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> > Can't you just create a pre-reserved separate swsusp area on 
> > disk the size 
> > of RAM (maybe a partition rather than a file to make things 
> > easier), and 
> > then you know you're safe (basically what Marc was 
> > suggesting, except pre-allocated)? Or does that make me the 
> > prince of all evil? ;-)
> > 
> > However much swap space you allocate, it can always all be 
> > used, so that seems futile ...
> 
> This is what Other OSes do, and I believe this is the correct path.
> Using swap for swsusp is a clever hack but not a 100% solution.

Well, for normal use its clearly inferior -- suspend partition is unused
when it could be used for speeding system up by swapping out unused
stuff.

OtherOS approach is better because it can guarantee suspend-to-disk
for critical situations like overheat or battery-critical.

But we can get best of both worlds if we OOM-kill during critical
suspend. [If suspend partition was not used for swapping, machine
would *already* OOM-killed someone, so we are only improving stuff].

						Pavel  

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
