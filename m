Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVCNEwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVCNEwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVCNEwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:52:49 -0500
Received: from mail.aknet.ru ([217.67.122.194]:50450 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261425AbVCNEwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:52:41 -0500
Message-ID: <423518A7.9030704@aknet.ru>
Date: Mon, 14 Mar 2005 07:52:55 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:
> Btw, Stas, one thing I'd really like to see is even a partial list of 
> anything that actually cares about this. Ie, if there is some known 
> Windows app where Wine works better or something like that, just adding
I am not using Wine too much, but I've
found this:
http://cvs.winehq.org/cvsweb/~checkout~/wine/dlls/winedos/int31.c?rev=1.41&content-type=text/plain
---
/* due to a flaw in some CPUs (at least mine), it is best to mark stack segments as 32-bit if they
   can be used in 32-bit code. Otherwise, these CPUs may not set the high word of esp during a
   ring transition (from kernel code) to the 16-bit stack, and this causes trouble if executing
   32-bit code using this stack. */
---
I added win-devel to CC, maybe people there
can tell if that patch has any value for them
or not.
The reference to the original patch:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.1/1794.html

Dosemu looks a little better on that, the
whole chapter of the docs is dedicated to
that problem:
http://dosemu.sourceforge.net/docs/EMUfailure/t1.html#AEN55
There you can find a (relatively small)
list of the programs that are affected,
but I personally have the old Microsoft
linker that crashes, and a few more DOS
games.

> Another way of saying the same thing: I absolutely hate seeing patches 
> that fix some theoretical issue that no Linux apps will ever care about. 
No, it is not theoretical, but it is mainly
about a DOS games and an MS linker, as for
me. The things I'd like to get working, but
the ones you may not care too much about:)
The particular game I want to get working,
is "Master of Orion 2" for DOS.

> So I'd like to have a bit more of a case for this patch, since I know what 
> the case against it is ;)
Yep, and the informational leak it closes,
looks also rather minor.
So it is only a matter of how do you care
about the dosemu and the DOS games under
linux. Considering the amount of the
dosemu-related code in vm86.c, I guess you
care:)
And uhm, adding the list of the DOS games
to the comments of the Linux kernel code,
doesn't sound like a good idea to me:)

