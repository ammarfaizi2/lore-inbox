Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261592AbSJAMN0>; Tue, 1 Oct 2002 08:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJAMN0>; Tue, 1 Oct 2002 08:13:26 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:24533 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S261592AbSJAMNW>; Tue, 1 Oct 2002 08:13:22 -0400
Message-Id: <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net>
Date: Tue, 1 Oct 2002 08:31:05 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001115413.B9131@ucw.cz>; from vojtech@suse.cz on Tue, Oct 01, 2002 at 11:54:13AM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop016.verizon.net from [141.150.241.241] at Tue, 1 Oct 2002 07:18:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Mon, Sep 30, 2002 at 10:40:10AM -0400, Skip Ford wrote:
> 
> > I can no longer change keycodes since switching to the new input layer.
> > Has anyone been able to?
> 
> I've tested it and it should work. What exactly doesn't work for you?
> What are you trying to do?

I'm trying to assign keycodes using the kbd package.  Multimedia keys
and some regular keys.  Here is one example.  The key I'm pressing is
e05e.

~# showkey
kb mode was XLATE

press any key (program terminates 10s after last keypress)...
keycode 116 press
keycode 116 release

~# getkeycodes
Plain scancodes xx (hex) versus keycodes (dec)
0 is an error; for 1-88 (0x01-0x58) scancode equals keycode

 0x58:   88  54  28  27   0  43   0   0
 0x60:   85  86  90  91  92  93  14  94
 0x68:   95  79   0  75  71 121   0 123
 0x70:   82  83  80  76  77  72   1  69
 0x78:   87  78  81  74  55  73  70  99

Escaped scancodes e0 xx (hex)

e0 00:  252   0   0  65  99   0   0   0
e0 08:    0   0   0   0   0   0   0   0
e0 10:    0   0   0   0   0   0   0   0
e0 18:    0   0   0   0   0   0   0   0
e0 20:    0   0   0   0   0   0   0   0
e0 28:    0   0 251   0   0   0   0   0
e0 30:    0   0   0   0   0   0   0   0
e0 38:    0   0   0   0   0   0   0   0
e0 40:    0   0   0   0   0   0   0   0
e0 48:    0   0   0   0   0   0   0   0
e0 50:    0   0   0   0   0   0   0   0
e0 58:    0   0   0   0   0   0   0   0
                                 ^^^     <-- e05e
e0 60:  252 253   0   0   0   0   0   0
e0 68:    0   0   0   0   0   0   0   0
e0 70:  254   0   0   0   0   0   0   0
e0 78:    0   0   0   0   0   0   0 255

~# setkeycodes e05e 89
~# getkeycodes
Plain scancodes xx (hex) versus keycodes (dec)
0 is an error; for 1-88 (0x01-0x58) scancode equals keycode

 0x58:   88  54  28  27   0  43   0   0
 0x60:   85  86  90  91  92  93  14  94
 0x68:   95  79   0  75  71 121   0 123
 0x70:   82  83  80  76  77  72   1  69
 0x78:   87  78  81  74  55  73  70  99

Escaped scancodes e0 xx (hex)

e0 00:  252   0   0  65  99   0   0   0
e0 08:    0   0   0   0   0   0   0   0
e0 10:    0   0   0   0   0   0   0   0
e0 18:    0   0   0   0   0   0   0   0
e0 20:    0   0   0   0   0   0   0   0
e0 28:    0   0 251   0   0   0   0   0
e0 30:    0   0   0   0   0   0   0   0
e0 38:    0   0   0   0   0   0   0   0
e0 40:    0   0   0   0   0   0   0   0
e0 48:    0   0   0   0   0   0   0   0
e0 50:    0   0   0   0   0   0   0   0
e0 58:    0   0   0   0   0   0  89   0
                                ^^^^     <-- e05e
e0 60:  252 253   0   0   0   0   0   0
e0 68:    0   0   0   0   0   0   0   0
e0 70:  254   0   0   0   0   0   0   0
e0 78:    0   0   0   0   0   0   0 255

~# showkey
kb mode was XLATE

press any key (program terminates 10s after last keypress)...
keycode 116 press
keycode 116 release

----------------------------------------------------------
The same thing happens with every key.  I've tried every config option
that seems even remotely related to keyboards and nothing changes.  It's
detected as:

input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

It's a PS2 keyboard attached via PS2/AT adapter.  The actual changes I'm
trying to make are the same ones I've been using through all of 2.4 and
2.5

-- 
Skip
