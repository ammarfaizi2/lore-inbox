Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTFHAaN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFHAaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:30:13 -0400
Received: from smtp.terra.es ([213.4.129.129]:28845 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S264186AbTFHA35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:29:57 -0400
Date: Sun, 8 Jun 2003 02:43:13 +0200
From: Arador <grundig@teleline.es>
To: Pavel Machek <pavel@suse.cz>
Cc: hch@infradead.org, ak@muc.de, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on
 CONFIG_EMBEDDED
Message-Id: <20030608024313.0280ae8e.grundig@teleline.es>
In-Reply-To: <20030607204340.GC667@elf.ucw.cz>
References: <20030607063424.GA12616@averell>
	<20030607082651.A18894@infradead.org>
	<20030607204340.GC667@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003 22:43:40 +0200
Pavel Machek <pavel@suse.cz> wrote:

> Its more like "make oldconfig" limitation, IIRC. If you have some old
> config, it ignores defconfig and suggests you N for new options. And
> yes people were hitting that.

Even if they're not using oldconfig, some people i know uses to put
it as module (they use to think in "put everything you can as module")


I suggest hidding this under "input device support":
 <*> Input devices (needed for keyboard, mouse, ...)    
 <*> Serial i/o support (needed for keyboard and mouse)
 <*>   i8042 PC Keyboard controller 
 <*>   Serial port line discipline
 [*] Keyboards
 <*>   AT keyboard support
 [*] Mice
 <*>   PS/2 mouse
 <*>   Serial mouse

and enable all of them by default

Then make a 
 [ ] Advanced Input Device Support

which will show those menues and it will let
people to disable those very common options.
I mean, IMHO users who want to disable
PS/2 and keyboard support are "advanced" users
which want to enable/disable "advanced" options.


Personally i think this scheme also sucks,
"input device support" should be changed; and bad names should be killed
(in the real world who knows what a "<*> i8042 PC Keyboard controller" means)
so people really knows that they won't be able to type anything if they disable it.
In fact, they're not warned anywhere that they won't get a console if they don't
enable it. And the fact that the help entries say nothing about it, and
that we're supposed to be disabling "input", not "output" support makes it harder
for people to understand when configuring their first 2.5 kernel.

I can't count how many people i've seen falling this on irc (personally it took
me 3 times to get the right options; unexperienced people could take forever).
If this isn't changed it will be the most reported ever (personally i'd consider
it a "must-fix" item ;) as it could have very negative effects when 2.6 is out =)


Just my thougs; Diego Calleja.

