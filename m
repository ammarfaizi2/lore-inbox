Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVARLZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVARLZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVARLZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:25:08 -0500
Received: from ranger.systems.pipex.net ([62.241.162.32]:1216 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261275AbVARLZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:25:00 -0500
Date: Tue, 18 Jan 2005 11:25:55 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjan@infradead.org>,
       Jan Hubicka <jh@suse.cz>, Jack F Vogel <jfv@bluesong.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <41EC224D.5080204@zytor.com>
Message-ID: <Pine.LNX.4.61.0501181112120.2911@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
 <cs9v6f$3tj$1@terminus.zytor.com> <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
 <1105955608.6304.60.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
 <41EBFF87.6080105@zytor.com> <m1wtubvm8y.fsf@muc.de> <41EC224D.5080204@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, H. Peter Anvin wrote:
> Or does kdb not have a client at all?  (If so, I have no sympathy for it.)

Peter, it was very easy for you to call my emails "rants" and "not even 
funny" but the above statement is displaying complete ignorance of what 
kdb actually is :) So, instead of "patronizing" your fellow-hacker, please 
listen to what he has to say below:

I already solved this paricular problem. And the solution is (but don't 
tell me you knew it, for then why didn't you tell anyone) simply --- 
compile the kernel with -g and that includes enough debug information to 
be able to decode the stack content correctly. And yes, kdb does show the 
correct argument values now. No changes to kdb are necessary and no need 
to do the work with dwarf2 implementation etc etc.

However, this highlighted a more serious problem in the x86_64 kernel (or 
more likely in the kdb patch) --- the kernel compiled with -g panics when 
you try to return from kdb after hitting a breakpoint. This is a bug and 
I'll investigate to find out the reason why it panics. (I hope it is not 
an "assumption" of the x86_64 port that one must never compile the kernel 
with -g either...)

Kind regards
Tigran
