Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTFZSnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFZSnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:43:55 -0400
Received: from roc-24-169-2-225.rochester.rr.com ([24.169.2.225]:41111 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP id S262321AbTFZSnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:43:49 -0400
Date: Thu, 26 Jun 2003 14:57:52 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics support kills my mouse
In-Reply-To: <20030626104546.GA12096@arm.t19.ds.pwr.wroc.pl>
Message-ID: <Pine.LNX.4.56.0306261453110.530@death>
References: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
 <20030626104546.GA12096@arm.t19.ds.pwr.wroc.pl>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Arkadiusz Miskiewicz wrote:

> I have the same problem. I'm using MaxData Mbook 1000T which has
> synaptics touchpad too and it stopped working in .72 and still doesn't
> work in .73 :-(
>
> Synaptics Touchpad, model: 1
>  Firware: 4.1
>  Sensor: 8
>  new absolute packet format
> input: Synaptics Synaptics TouchPad on isa0060/serio2
> mice: PS/2 mouse device common for all mice
>
> I tried to use XFree86 4.3.99.6 with
> http://w1.894.telia.com/~u89404340/touchpad/ driver but that doesn't
> work either:
>
> Doesn't work means that button presses nor touchpad moves are not detected.
>
> btw. which driver provides /dev/input/inputX (as in xfree synaptics
> driver documentation) ? I found only /dev/input/eventX driver.

I'm not the author of the driver but I do have my touchpad mostly working
(tap to click doesn't work but I can move the pointer and click buttons).

Make sure you load the synaptics module in XF86Config... then you want
your pointer section to look something like:

Section "InputDevice"
        Identifier      "MouseS"
        Driver          "synaptics"
        Option  "device" "/dev/input/event1"
        option  "protocol" "event"
        Option  "edges" "1900 5400 1800 3900"
        Option  "Finger" "25 30"
        Option  "MaxTapTime" "20"
        Option  "MaxTapMove" "220"
        Option  "VertScrollDelta" "100"
        Option  "MinSpeed" "0.02"
        Option  "MaxSpeed" "0.18"
        Option  "AccelFactor" "0.0010"
        Option  "Emulate3Buttons" "on"
        Option  "EmulateMidButtonTime" "20"
EndSection

it uses the event devices, not the mouse devices.

-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken

