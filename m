Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUANFJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266301AbUANFJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:09:40 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:12247 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266297AbUANFJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:09:39 -0500
Date: Wed, 14 Jan 2004 05:08:18 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BIOS Flash changes PowerNOW frequencies?
Message-ID: <20040114050818.GC23845@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040111175610.GA26855@dotnetslash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111175610.GA26855@dotnetslash.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 12:56:10PM -0500, Mark W. Alexander wrote:
 > I'm not currently subscribed. Please cc: me on responses.
 > 
 > I'm running 2.6.0 on an HP Pavilion ze4420 Athlon version (lspci -v below).  I
 > recently flashed the BIOS (hoping against all odds for suspend to ram
 > capability) and the CPU frequencies discovered by PowerNOW (K7) has changed.
 > This is obviously caused by the BIOS update, but the stupid question of the day
 > is "Why?". If the CPU and chipset support both sets of frequencies with
 > different BIOS, wouldn't the _real_ set of supported frequencies be the union
 > of the 2?

In reality, yes.
However BIOS programmers have a different perception of reality to the rest of us.
The spec for PST tables allows for up to 256 FID/VID pairs, yet everyone just
seems to offer 5-6 as maximum. I guess they figured no-one needed the granularity
of the full range.

 > As startling as it was to come up at 532Mhz the first boot, I can see where
 > this could provide some dramatic power savings (say, while using vi),
 > but the now missing 1064, 1463 and 1596 frequencies were more practical
 > for actually doing something worthwhile (say, using vi while watching a
 > DVD ;).
 > Is there anything I can do to persuade PowerNOW/frequency scaling to see the
 > full range of frequencies that I've seen this box can do?

Something that has been planned for quite a while has been a means of overriding
the tables using sysfs. I haven't had time to implement this, and no-one else
has found the time/motivation to do so either it seems.

Something I was tempted to do at one point (due to the number of broken PST's out
there) was to offer a 'ignore_pst' module parameter, which exposed the full table
to sysfs. The only problem being some VRMs can't handle certain frequencies at
certain voltages whilst some can, making it hard to find a set of 'safe' values
for each frequency.

How to find out which one VRM can handle frequency X at voltage Y ?
Through the PST tables.

*sigh*, back to the drawing board.

		Dave

