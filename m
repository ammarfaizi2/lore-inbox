Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSJUDKX>; Sun, 20 Oct 2002 23:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSJUDKW>; Sun, 20 Oct 2002 23:10:22 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48041 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264705AbSJUDKV>; Sun, 20 Oct 2002 23:10:21 -0400
Date: Sun, 20 Oct 2002 19:44:42 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42,
 2.5.41 boot hang with CONFIG_USB_DEBUG=n
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <3DB36A1A.5040802@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021013172557.GA890@rousalka.noos.fr>
 <3DAAF67F.1080504@pacbell.net> <20021014212000.GA1002@rousalka.noos.fr>
 <3DAC4BE8.6080109@pacbell.net> <20021018174553.GA1271@rousalka.noos.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> init timing.  Experiment:  leave all debug messages off, but change
>> the first dbg() call in hc_reset() into an err() call.  Does that make
>> things better?
> 
> 
> The answer is yes.

I'll submit a patch to make that arbitrary timeout longer, and make
sure the debug messages won't affect that timing again.


> I feel changing dbg() in err() is a bit worse than full 
> CONFIG_USB_DEBUG=y. It certainly did hang more often at boot than with  
> CONFIG_USB_DEBUG=y. However :
> * with err() I get about 50% boot chance
> * with err() I've never so far booted with a useless keyboard (sole 
> times I booted with unchanged kernel and CONFIG_USB_DEBUG=n keyboard was 
> dead)
> * when it hangs with err() the takeover message is printed (never was 
> before on hang)

I think there's something funky about your BIOS, causing these boot
time problems.  That takeover problem should _never_ happen.  Can you
still get BIOS updates for that motherboard?


> Sometimes after  2.5.43 is booted switching to the console freezes the 
> usb mouse. Don't know if it's related to the boot hang, but 
> chain-restarting gpm will more often result into an oops than a 
> recovered mouse. However I've just found that re-pluging it instead of 
> restarting gpm unfreezes the mouse cursor.

That'd seem to be a different problem.

> drivers/usb/host/ohci-q.c: 00:07.4 bad entry 5fb7d1e1
> drivers/usb/host/ohci-q.c: 00:07.4 bad entry ffffffe1
> drivers/usb/host/ohci-q.c: 00:07.4 bad entry 5fb7d1e1
> drivers/usb/host/ohci-q.c: 00:07.4 bad entry ffffffe1
> drivers/usb/core/usb.c: USB disconnect on device 4
> drivers/usb/core/hub.c: new USB device 00:07.4-2.3, assigned address 6
> input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-00:07.4-2.3
> 
> 
> The « drivers/usb/host/ohci-q.c: 00:07.4 bad entry » are triggerred by 
> gpm failing to restart.

Now that's the wierdest clue to that failure I've seen yet!  :)

Good that for you it didn't seem to cause other trouble.  I'm
starting to think I probably know where that problem must live.

- Dave


