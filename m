Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUG2Ssk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUG2Ssk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUG2SnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:43:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5017 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S266635AbUG2Onu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:43:50 -0400
Date: Thu, 29 Jul 2004 07:43:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Kumar Gala <kumar.gala@freescale.com>, Sylvain Munaut <tnt@246tNt.com>,
       linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       olh@suse.de, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040729144347.GE16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20040729100549.pochini@shiny.it>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:05:49AM +0200, Giuliano Pochini wrote:

> On 28-Jul-2004 Tom Rini wrote:
> 
> > I've taken the binutils-2.14+gcc-3.4 bit out (and none of the other
> > cleanups) as it seems like we get 1-2 reports a week from this bad tools
> > combination:
> 
> I had no time to do a lot of testing, but it seems that binutils 2.15 +
> gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
> may also break), but at least I couldn't compile gcc 3.4.1 with the
> above combination. It seems that as doesn't get the -mxxx parameter
> required to compile altivec stuff. Hacking the Makefile to make it
> pass -Wa,-m7455 helped a little, but it eventually failed in another
> weird way. I hadn't time to investigate further, sorry.

Stock gcc-3.3.3 or from the hammer branch?  There is, I think, a second
problem that was left out.  The problem with gcc-3.4 + binutils-2.14 is
that -many gets passed, which zeros out previous flags.  -many is fine
in binutils-2.15 (and 2.13 and 2.12 and 2.12.1 it seems), but 2.15 does
require -maltivec to be passed in order to handle altivec instructions.
Getting this right was part of the cleanup that conflicted with the
mpc52xx changes (Andrew: trying to take care of getting this into Linus'
tree now).

-- 
Tom Rini
http://gate.crashing.org/~trini/
