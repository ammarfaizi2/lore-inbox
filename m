Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbULaRao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbULaRao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbULaRao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:30:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:55993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262121AbULaRaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:30:35 -0500
Date: Fri, 31 Dec 2004 09:30:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@muc.de>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412310654280.10484@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0412310921050.2280@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <m1mzvvjs3k.fsf@muc.de>
 <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org> <20041231123538.GA18209@muc.de>
 <Pine.LNX.4.58.0412310654280.10484@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Davide Libenzi wrote:
> 
> I don't think that the Wine problem resolution is due to the POPF 
> instruction handling. Basically Linus patch does a nice cleanup plus POPF 
> handling, so maybe the patch can be split.

The popf part is very nice in that it allows you to single-step and debug 
this thing.

The fact is, I can't debug Wine. The code-base is just too alien for me, 
so to debug this thing I needed to come up with a silly example of TF 
usage, and try to debug _that_ instead as if it were something unknown (ie 
debugging by knowing what the program does is a no-no, since that would 
have defeated the whole exercise).

And handlign "popf" correctly really was the only sane way to debug it, 
anything else would never have worked in a real-life debugging situation. 
It's easy enough to say "well, just do it by hand", but that's not 
practical when you debug with "si 1000" to try to pinpoint the behaviour a 
bit.

And clearly my debuggability exercise seem to have worked, since the end
result apparently ended up doing the right thing for Wine.

This is why debuggability is important. I realize that people may think 
I'm inconsistent (since I abhor kernel debuggers), but while _I_ abhor 
debuggers, I also think that the primary objective of an operating system 
is to make easy things easy, and hard things possible, so while I don't 
much like debuggers, I consider it a fundamental failure if the kernel 
doesn't have proper support for them.

So I think it's worth splitting out the "popf" part of the patch, but even
if that one doesn't actually matter for Warcraft, I'd put it in just so 
that we have a state where we're _supposed_ to be able to debug things 
with TF in them. Just having the mental expectation that things like that 
should work is important - otherwise we'll eventually end up having some 
other subtle problem with TF handling.

			Linus
