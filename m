Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272090AbRIJW4Z>; Mon, 10 Sep 2001 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272102AbRIJW4P>; Mon, 10 Sep 2001 18:56:15 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:10002 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272088AbRIJWz7>; Mon, 10 Sep 2001 18:55:59 -0400
Message-ID: <3B9D44D1.E96C831F@t-online.de>
Date: Tue, 11 Sep 2001 00:55:13 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109102242.f8AMgpY21341@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" schrieb:
> 
> >> Something other made me wonder:
> >> I ran the machine several times with the *new* aic7xxx-driver (TCQ=32)
> >> and the "aic7xxx=verbose" commandline, and i noticed the following:
> >> At every reboot (made by "reboot", RH7.1), the machine was not able to
> >> stop the raid5 correctly...it un-mounted the mountpoint (/home) and then
> >> it normaly wants to stop the raid...(you see the messages "mdrecoveryd
> >> got waken up...") but that did not work and after some time (30sec) the
> >> kernel Ooopsed.
> 
> ...
> 
> >Same behaviour for RAID1 and the new aic7xxx driver for me at nearly every
> >reboot. The old driver works just fine (2.4.9).
> 
> The new driver registers a "reboot notifier" with the system.  If MD
> continues to perform I/O after the aic7xxx driver's notification routine
> is called, the result is undefined.  The aic7xxx driver has already
> shutdown the hardware.  Perhaps I should use a different event to indicate
> it is safe for me to clean up the hardware?

What about a kind of timer ?

If the driver gets the "reboot"-note, watch for activity and shut down
the hardware 5 or 10 secs after the last activity ?

Shutting down the Userprocesses is done in a similar way..."Send
term"...sleep 5...Send Kill..."...and when this happens, all unmounts
and kills should have already occured, so it can only be a question of
<5 secs until the last (raid-) process has exited.

Other possibility would only be to let the kernel send this message just
before he reboots the maschine via a BIOS-call...but even then you would
have to wait a little until the hardware reacts...difficult problem...

Solong...
Frank

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
