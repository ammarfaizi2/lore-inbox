Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVBOUJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVBOUJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVBOUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:09:44 -0500
Received: from mail58-s.fg.online.no ([148.122.161.58]:34178 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261863AbVBOUCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:02:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz> <1108105875.5676.3.camel@localhost>
	<87vf8uee2q.fsf@quasar.esben-stien.name>
	<1108440859.26172.1.camel@localhost>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Tue, 15 Feb 2005 21:01:39 +0100
In-Reply-To: <1108440859.26172.1.camel@localhost> (Jeremy Nickurak's message
 of "Mon, 14 Feb 2005 21:14:18 -0700")
Message-ID: <87psz1fv8c.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak <atrus@lkml.spam.rifetech.com> writes:

> Section "InputDevice"
>     Identifier "Mouse0"
>     Driver "mouse"
>     Option "Protocol" "evdev"
>     Option "Device" "/dev/input/event-mx1000"
>     Option "Buttons" "12"
>     Option "ZAxisMapping" "11 12"
>     Option "Resolution" "800"
> EndSection

Section	"InputDevice" # MX1000
 Identifier 	"Mouse0"
 Driver 	"mouse"
 Option         "Protocol" "evdev"
 Option         "Dev Name" "Logitech USB Receiver" # cat /proc/bus/input/devices
 Option         "Dev Phys" "usb-0000:00:04.2-1/input0" # cat /proc/bus/input/devices
 Option         "Device" "/dev/input/event0" # (/dev/input/mice also appears to work)
 Option         "Buttons" "12"
 Option         "ZAxisMapping" "11 12"
 Option         "Resolution" "800"
EndSection

How did you get that /dev/input/event-mx1000?

> With an Xmodmap rule:
> pointer = 1 2 3 8 9 10 11 12 6 7 4 5

pointer = 1 2 3 6 7 8 9 10 11 12 4 5\n
 
which gives me..:

#1 = LMB
#2 = MMB
#3 = RMB
#4 = ROLL UP
#5 = ROLL DOWN
#6 = SIDE CLICK BACK
#7 = SIDE CLICK FORWARD
#8 = SIDE CLICK
#9 = TOP CLICK FORWARD
#10 = TOP CLICK BACK
#11 = HORIZONTAL LEFT
#12 = HORIZONTAL RIGHT

> This is to make sure that the scroll wheel shows up as 4/5 

Mine too

> and that the horizontal scroll shows up as 6/7 which most software
> interprets as the left/right scroll buttons.

I got mine on 11/12, but what do you mean most software interprets
horizontal scroll as 6/7?. This has to be incorrect. It's logical that
horizontal directions turns up as 11/12 along with top clicks as 9/10
and side click 8 as these features/buttons were the last added to the
mouse.

> Scroll Left:
>
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935139, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES
> 
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x10, button 5, same_screen YES
> 
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x1010, button 5, same_screen YES
> 
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935267, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES

KeyPress event, serial 26, synthetic YES, window 0x2800001,
    root 0x48, subw 0x0, time 0, (1,1), root:(1,1),
    state 0x0, keycode 102 (keysym 0xff53, Right), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 29, synthetic YES, window 0x2800001,
    root 0x48, subw 0x0, time 0, (1,1), root:(1,1),
    state 0x0, keycode 102 (keysym 0xff53, Right), same_screen YES,
    XLookupString gives 0 bytes: 

ButtonRelease event, serial 29, synthetic NO, window 0x2800001,
    root 0x48, subw 0x2800002, time 67867107, (35,38), root:(391,417),
    state 0x0, button 12, same_screen YES

> And right:
>
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935915, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES
> 
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x10, button 4, same_screen YES
> 
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x810, button 4, same_screen YES
> 
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334936027, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES

KeyPress event, serial 26, synthetic YES, window 0x2800001,
    root 0x48, subw 0x0, time 0, (1,1), root:(1,1),
    state 0x0, keycode 100 (keysym 0xff51, Left), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 29, synthetic YES, window 0x2800001,
    root 0x48, subw 0x0, time 0, (1,1), root:(1,1),
    state 0x0, keycode 100 (keysym 0xff51, Left), same_screen YES,
    XLookupString gives 0 bytes: 

ButtonRelease event, serial 29, synthetic NO, window 0x2800001,
    root 0x48, subw 0x2800002, time 68497761, (45,38), root:(424,440),
    state 0x0, button 11, same_screen YES

> I'm being very careful not accidentally press the horizontal scroller
> buttons. 

Why is that?

> [..] a different mouse configuration I'm supposed to be using [..]

We're obviously getting different data here from xev. You're using a
newer build, though. Are you running xbindkeys, btw?.

> the cruise control buttons, which still don't work quite
> right... see: http://bugzilla.kernel.org/show_bug.cgi?id=1786

I've never experienced this issue..!

> X.Org version: 6.8.1.902

6.8.1

> 2.6.11-rc3 

2.6.11-rc3-RT-V0.7.38-06. I got the realtime patches. 

For me, this is only a firefox issue now;). I got all buttons working
properly, but firefox got this damn issue. I'll do some thinking and
post to the firefox/mozilla mailinglist.

In firefox, btw, I got this setup: 

#1 = LMB
#2 = MMB
#3 = RMB
#4 = ROLL UP            - scroll manually down
#5 = ROLL DOWN          - scroll manually down
#6 = SIDE CLICK BACK    - back
#7 = SIDE CLICK FORWARD - forward
#8 = SIDE CLICK
#9 = TOP CLICK FORWARD  - scroll up
#10 = TOP CLICK BACK    - scroll down
#11 = HORIZONTAL LEFT   - scroll left  (firefox scrolls one cm to the left 
                                               and proceeds to scroll up)
#12 = HORIZONTAL RIGHT  - scroll right (firefox scrolls one cm to the right 
                                               and proceeds to scroll down)

So, an issue with firefox.

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name
