Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTEECit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTEECis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 22:38:48 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:58862 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261797AbTEECiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 22:38:46 -0400
Date: Sun, 04 May 2003 22:49:03 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: will be able to load new kernel without restarting?
In-reply-to: <20030504170947.GM27494@lug-owl.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200305042249030930.0040E04C@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
References: <freemail.20030403212422.18231@fm9.freemail.hu>
 <20030503205656.GA19352@middle.of.nowhere>
 <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
 <200305041200000380.00B553E1@smtp.comcast.net>
 <20030504170947.GM27494@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 5/4/2003 at 7:09 PM Jan-Benedict Glaw wrote:

>On Sun, 2003-05-04 12:00:00 -0400, rmoser <mlmoser@comcast.net>
>wrote in message <200305041200000380.00B553E1@smtp.comcast.net>:
>> You silly boys.  Thinking everything is impossible.  The old kernel
>> is just a shadow of the new one... just a shadow............  I'll try
>> spitting out a basic sketch.  This I'm sure you've done but if not,
>> fix it.  I'm an idiot, so this won't work as-is.
>> 
>> For starters, freeze the system.  halt EVERYTHING.
>> 
>> Now load the new kernel.
>> 
>> Now you have this thing in RAM.  Fine.  It's not running but it's in
>> RAM.
>> 
>> Start feeding data over to it.  In a manner it can understand.  You know,
>> make all the modules work with a standard named stream (check the
>> Advanced Tracker planning file at the very end:
>> http://advancedtracker.sourceforge.net/at/__at.plan.txt
>> I did copy it below, so you don't have to go there).  This is the
>> hard part--Module compatibility through defined names.  This would
>> bloat the kernel, so think about it and maybe you'll figure out a good
>> way.
>
>Sounds like being a nice feature (esp. for 24/7 uptime), but it also
>sounds like a *lot* of bloat. You'll have to encode (and to decode) any
>single bit if data. But - where to put all that? See, it you're having
>some Gigabytes of ram, you probably end with > 100MB only describing all
>those single pages (4..8K) of RAM. Encode that into a named stream - you
>end up with > 1GB of data. Then, you also need to encode the whole state
>of any drivers.
>
>What do you do if drivers/mm/you-name-it changed and now uses different
>data structures? In fact, any two choosen kernels may potentially use
>different data structures. So for the newly-to-load kernel, you need
>stream decoders for all possible older kernels. Bloat again.
>

Bloat yes.  But the idea is you keep the transit data structures the same.
It's doable.  It's not easy, but the modules, even with changing datastructures,
could understand what the stream means.  The data structures in the stream
need to be identified by module and function.  Then whatever a new module
has discarded, it discards.  Whatever it needs that's not there, it figures out
somehow.  If it can't, it tries to unload, and if it can unload, it notes all this.

When you're all done, ask the modules which work, which don't, and such.
See if it can go really.  If it can, do it.  If it can but some modules need to
reload, which aren't in use, reload them.  Feh, if some modules can't correlate
see if you can use the old kernel version!

>So if I would need something like that, I think kexec is the way to go,
>possibly with a second machine for failover (to even close the kexec
>booting gap).
>

Isn't that boot-without-bios?

>However - if you like this feature so much you'd die for: nobody stops
>you to implement a proof-of-concept:)
>

Do I look like I can code?  I'm a normal user--I write C, C++, but not
kernel-C.  And I can learn.  But if I crash something.  No.  I have one
machine, not something I can play with.  Well I can.  But I don't want
to blow it up.

>MfG, JBG
>
>-- 
>   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen
>Krieg
>    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>      ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.1 (GNU/Linux)
>
>iD8DBQE+tUlbHb1edYOZ4bsRAmTEAJ9nSPZCVtsbAVRogpBBFUCruvZaVACfb12C
>vZp7TCxxq7XbyYgeCGY8aK4=
>=+rM+
>-----END PGP SIGNATURE-----
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



