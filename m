Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTENSmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTENSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:42:13 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:47835 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263542AbTENSmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:42:10 -0400
Date: Wed, 14 May 2003 19:55:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Horsten <thomas@horsten.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include support for various K7 optimizations
Message-ID: <20030514185539.GA25542@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Horsten <thomas@horsten.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Michael Elizabeth Chastain <mec@shout.net>
References: <200305071834.26789.thomas@horsten.com> <20030514160449.B28115@suse.de> <200305141940.10999.thomas@horsten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305141940.10999.thomas@horsten.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:40:10PM +0100, Thomas Horsten wrote:

 > I think when GCC supports the different cores, it should be supported by the 
 > kernel scripts, the differences between the cores are real enough to have 
 > potential optimizations at least in theory (as far as I could see the only 
 > difference in GCC 3.2 is whether to use SSE, but that could change in the 
 > future).

To use SSE in kernel space, we need to wrap it in kernel_fpu_begin() /
kernel_fpu_end() pairs anyway. gcc doesn't (and can't) know this.

 > I think it's a fairly simple patch that doesn't break anything

it's non-obvious that it'll break things when people use broken compilers.
read what I wrote before, several gcc versions got this horribly wrong.
"athlon4" was even tuned for 64bit at one point.

Take away the SSE, take away the broken compiler versions, and you'd be
left with something that would hardly show a blip on a benchmark.

		Dave
