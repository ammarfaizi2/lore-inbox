Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSDOMPy>; Mon, 15 Apr 2002 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312588AbSDOMPx>; Mon, 15 Apr 2002 08:15:53 -0400
Received: from employees.nextframe.net ([212.169.100.200]:9724 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S312576AbSDOMPw>; Mon, 15 Apr 2002 08:15:52 -0400
Date: Mon, 15 Apr 2002 14:16:58 +0200
From: Morten Helgesen <admin@nextframe.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
Message-ID: <20020415141658.A140@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20020415112332.A181@sexything> <3CBA8E70.5010605@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again, Martin :)

What do you think about the following :

--- clean-linux-2.5.8/drivers/ide/ide.c Sun Apr 14 21:18:52 2002
+++ patched-linux-2.5.8/drivers/ide/ide.c       Mon Apr 15 14:09:18 2002
@@ -3120,7 +3120,7 @@
        /*
         * Look for bus speed option:  "idebus="
         */
-       if (strncmp(s, "idebus", 6)) {
+       if (strncmp(s, "idebus", 6) == 0) {
                if (match_parm(&s[6], NULL, vals, 1) != 1)
                        goto bad_option;
                if (vals[0] >= 20 && vals[0] <= 66) {

gives :

Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
ide_setup: idebus=66
ide: system bus speed 66MHz

works like a charm :)

== Morten

On Mon, Apr 15, 2002 at 10:25:20AM +0200, Martin Dalecki wrote:
> Morten Helgesen wrote:
> >Hey Martin (and the rest of you)
> 
> >Now, I do not know the reasons for changing the code that handles "idebus=" 
> >stuff in ide.c (except from the fact
> 
> Should be an off by one error there.
> 
> >that it now looks cleaner :) - just thought I should let you know. I do not 
> >have the time right now to hunt down
> >the bug(?) and cook up a patch, but if you want me to, I`ll do it later 
> >today. 
> 
> I would love if you could have a look at it...
> 
> >One more thing, Martin - I compiled a 2.5.8 with TCQ enabled (yep, I`m 
> >aware of the fact that this one is _really_ alpha :), and tested it for, oh 
> >... 10 minutes ... the system gave me all sorts of funny responses - 
> >segfaults, "inconsistency in ld.so" and so on ... would you like me to 
> >collect 'funnies' and send them to you ? If so, just give me a hint.
> 
> Thats mostly Jens stuff...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
