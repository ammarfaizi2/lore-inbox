Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWD3JkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWD3JkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 05:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWD3JkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 05:40:25 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:59068 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751086AbWD3JkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 05:40:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17492.34204.844839.262357@wombat.chubb.wattle.id.au>
Date: Sun, 30 Apr 2006 19:38:36 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, David Woodhouse <dwmw2@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	<1146105458.2885.37.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	<1146107871.2885.60.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	<20060427213754.GU3570@stusta.de>
	<Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> On Thu, 27 Apr 2006, Adrian Bunk wrote:
>>  A definition of the kernel <-> userspace ABI is required.


Linus> This is one reason why we shouldn't even _plan_ on having
Linus> header files that can just be _directly_ used by the C
Linus> libraries etc, even if it's just a "small" kernel ABI header.

I think I disagree with you here.  It should be possible to have Linux
kernel abi header files that are directly usable, and shared between
kernel and user space, precisely because they are _Linux_ kernel ABI
headers, not POSIX, not SUS, not XOPEN_SOURCE.  The consumers of the
header files shouldn't expect to be able necessarily to do 
       #include <stdio.h>
       $include <linux/kabi/xxx.h>
and have it work (although I think we should avoid breaking things if
it's easy to do so), because that's mixing interface definitions --
libc vs raw Linux.

Originally (back in edition 6 days) /usr/include/sys was precisely the
kind of thing that's being proposed, in that it contained system call
numbers, and the shapes of structures shared between user and kernel
space.  Over time, that directory became a compatibility layer for
POSIX-like systems, and has been implemented in terms of whatever the
OS provides.  So now we need something new.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
