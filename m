Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTFUUgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbTFUUgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:36:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:21896 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265326AbTFUUgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:36:53 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 21 Jun 2003 13:49:15 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Winischhofer <thomas@winischhofer.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SiS IRQ router 96x detection (2.5.69) ...
In-Reply-To: <1056198220.25975.23.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0306211314400.3725@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306022338530.3631@bigblue.dev.mcafeelabs.com> 
 <3EF248F9.7040402@winischhofer.net> <1056198220.25975.23.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003, Alan Cox wrote:

> On Gwe, 2003-06-20 at 00:36, Thomas Winischhofer wrote:
> > Since the attached patch does not show up in any of the main line
> > kernels yet, may I assume it has been overlooked?
>
> I saw it yes, and decided it was too ugly for words

I have to admit that I was tempted to let this go through by simply
ignoring you. But I can't sorry, I can't ear this words from someone that
is supposed to work to improve the kernel. The patch is really simple. The
SiS SB keeps the same device id but it implements two different
behaviours, with the 96x one that breaks the current IRQ routing code. The
current device-id->router selection scheme simply does not work under this
conditions, since the SB maintain the same device id. There are two
options that I can see. The first, that I implemented inside the patch,
add an extra "detect" function to the router structure to handle cases
where the current device-id->router selection fails. The other one is to
do either the device recognition inside each get/set call or to do some
magic inside the first get/set called and store the detect result inside
the structure (or, even uglier, in some global variable). I believe that
the "detect" function will give a more generic approach to the
device-id->router selection. You objected that I added esplicit NULL
initialization to detect functions that was useless and my objection was
that using the old field-order-based initialization like :

struct meaw = { v1, v2, ... };

it was cleaner to have explicit member initialization. I also said that if
you wanted to remove some field initialization it'd have been cleaner to
use the C99 style :

struct meaw = { .f1 = v1, .f2 = v2 ... };

Personally I don't give a *damn* if you merge or not the patch. Patches
for 2.4 and 2.5 are inside my "to-apply" folder (that are automatically
applied by my scripts) and make my machine to work with Linux. The only
annoing thing was ppl asking me the patch directly, but now I dropped them
on my http server and hopefully google will pick 'em up. You still have a
broken kernel though.



- Davide

