Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUJAAdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUJAAdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUJAAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:33:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:31430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269636AbUJAAde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:33:34 -0400
Date: Thu, 30 Sep 2004 17:31:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Message-Id: <20040930173116.6de40c54.rddunlap@osdl.org>
In-Reply-To: <1096590131l.11697l.1l@werewolf.able.es>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	<1096586774l.5206l.1l@werewolf.able.es>
	<20040930170505.6536197c.akpm@osdl.org>
	<1096589834l.11697l.0l@werewolf.able.es>
	<1096590131l.11697l.1l@werewolf.able.es>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 00:22:11 +0000 J.A. Magallon wrote:

| 
| On 2004.10.01, J.A. Magallon wrote:
| > 
| > On 2004.10.01, Andrew Morton wrote:
| > > "J.A. Magallon" <jamagallon@able.es> wrote:
| > > >
| > > > 
| > > > On 2004.09.27, Andrew Morton wrote:
| > > > > 
| > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/
| > > > > 
| > > > > - ppc64 builds are busted due to breakage in bk-pci.patch
| > > > > 
| > > > > - sparc64 builds are busted too.  Also due to pci problems.
| > > > > 
| > > > > - Various updates to various things.  In particular, a kswapd artifact which
| > > > >   could cause too much swapout was fixed.
| > > > > 
| > > > > - I shall be offline for most of this week.
| > > > > 
| > > > 
| > > > I have a 'little' problem. PS2 mouse is jerky as hell, an when you mismatch
| > > > the protocol in X. Both in console and X.
| > > 
| > > The above sentence is a bit hard to decrypt.  Want to try again?
| > > 
| > 
| > Sorry, it is late and I try to type faster than I think...
| > 
| > Problem: my PS2 trackball is not working. When I move it, the cursor (both
| > in console and in X) jumps, instead of smoothly following the ball. The
| > behavior is similar as when (in old days) you tried to use a mouse in X and
| > put the wrong 'Protocol' in XF86Config. Or as if the driver was only
| > getting one interrupt out of each hundred. Now with /dev/input/mice you don't.
| > have to explicitly say the protocol.
| > 
| 
| I have found this on dmesg. Is it correct ?
| 
| mice: PS/2 mouse device common for all mice
| input: AT Translated Set 2 keyboard on isa0060/serio0
| input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
| 
| If not, how can I change the protocol ? A kernel bootparam ?
| In old X, i used 'Option "Protocol" "MouseManPlusPS/2"'.

>From Documentation/kernel-parameters.txt:

	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
			probe for (bare|imps|exps).

so for builtin mouse driver (not a loadable module), use:
	psmouse.proto=bare|imps|exps

However, it read/sounds like the protocol is probed/detected.
Moreover, it also sounds like MouseManPlusPS/2 isn't listed/supported.
The known protocols according to psmouse-base.c are:

static char *psmouse_protocols[] = {
  "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};

I guess that you can test:  psmouse.proto=bare
or each listed option to see what helps.

--
~Randy
