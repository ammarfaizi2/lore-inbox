Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBBJob>; Fri, 2 Feb 2001 04:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRBBJoV>; Fri, 2 Feb 2001 04:44:21 -0500
Received: from alex.intersurf.net ([216.115.129.11]:59399 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129027AbRBBJoH>; Fri, 2 Feb 2001 04:44:07 -0500
Message-ID: <XFMail.20010202034407.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010201231806.B2684@grobbebol.xs4all.nl>
Date: Fri, 02 Feb 2001 03:44:07 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Subject: Re: esp causing crashes..
Cc: linux-kernel@vger.kernel.org, arobinso@nyx.net, miquels@cistron.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01-Feb-2001 Roeland Th. Jansen wrote:
> On Thu, Feb 01, 2001 at 03:38:28PM -0600, Mark Orr wrote:
>> I dont like to be the sort of person who, when people report problems,
>> fires back "it works fine here!"...but...just as a point of reference,
>> I have a Hayes ESP too -- it's connected to a 56k modem.  I havent
>> had any crashes or hangs related to it, but I dont use mgetty.  (I use
>> rungetty, a variant of mingetty,  for VC's).    Seeing this, I will
>> compile up mgetty here to see if I can replicate it.
> 
> 
> even without mgetty it fails. the fact hat esp.o is loaded is cause for
> trouble. minicom using the card, exit - crash.

Well that surely shouldnt happen...I use minicom all the time (I still
call BBSes), and havent had any crashes.  I can quit/disconnect, or 
quit/stay connected and it works okay.   I've even got it set up to
use 230000bps, which is the max my Zoom will take.

When I was trying to set up the ESP shortly after I'd received it,
there was some trial+error to get the address/irq/dma/jumpers set right,
and minicom would hang (the program), but I could kill it.  It took about
an hour to get the settings the way I'd wanted them, and since then...
no real problems.

> I do not use the DMA channel of the card as it conflicts with the SB16 I
> have on board.

I also have a SB16 (non-PnP).  I use DMA 1 and 5 for the SB16 and 3 for
the ESP.    I dont know if it's doing anything though...wish there were a
way to know how deep into the buffers it ever gets on transfers.  DMA
threshold on mine is the default value (I believe it's 32 bytes) -- it
wouldnt suprise me if it didnt get that deep, keeping the rx_threshold
so low.

My modules.conf ESP section looks like:

#
# Hayes ESP module + options
# port 180h, irq 3, dma 3, divisor 4
options esp irq=0,0,3,0,0,0,0,0 dma=3 divisor=0,0,0x04,0,0,0,0,0 rx_timeout=1
post-install esp setserial /dev/ttyP16 low_latency
alias char-major-57 esp
alias chat-major-58 esp

Only troubles it's given me lately is that esp.c isnt a devfs-aware
driver.  I've been experimenting with devfs lately, so I have to do
a "mknod /dev/ttyP16 c 57 16" every time I boot, and it still barks out
a few meaningless errors (cup: device already registered).
I just have the one-port ESP card.

--
Mark Orr
markorr@intersurf.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
