Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbQKGA1Q>; Mon, 6 Nov 2000 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbQKGA1G>; Mon, 6 Nov 2000 19:27:06 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:34239 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129236AbQKGA04>; Mon, 6 Nov 2000 19:26:56 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Evan Jeffrey <hobbes@utrek.dhs.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 00:23:06 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, hobbes@utrek.dhs.org
In-Reply-To: <200011062046.OAA10302@utrek.dhs.org>
In-Reply-To: <200011062046.OAA10302@utrek.dhs.org>
MIME-Version: 1.0
Message-Id: <00110700263301.00940@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Evan Jeffrey wrote:
> > On Mon, 06 Nov 2000, David Woodhouse wrote:
> > > 
> > > No. You have to reset the hardware fully each time you load the module. 
> > > Although you _expect_ it to be in the state in which you left it, you can't
> >  
> > > be sure of that. 
> > 
> > If a reset is needed, I think it should come explicitly from userspace.
>  
> Take Alan's example of a USB device, say USB audio.  If it is disconnected
> and reconnected to add a hub, or anything else, the device may shut itself
> down, go to an undefined state, or even power cycle (if it draws power from 
> the USB +5V).  Same with hot-swap PCI cards.  The driver *MUST* reset the 
> device on load.  If saving mixer levels through this kind of transition is 
> desired (which it evidentally is), the module load/unload code must save and 
> restore the settings.

I'm not convinced.

> This is exactly equivelent to reseting hardware after a warm boot. 

Interesting. If that were done, my last sound card wouldn't have worked at all
under Linux: it had to be initialised under DOS before loading Linux. Had Linux
then reset everything, I'd have been soundless!

> Who knows
> what the Windows driver did to your card in the mean time. 

Either it initialises it (as it does, in this case), and I want (even NEED) it
to STAY initialised (i.e. if your driver does an unnecessary reset, your driver
is broken), or it doesn't, and I'll reset the card with an ioctl.

> A device driver
> can only guarantee that nobody horkes with its hardware while it is loaded--
> In the interim, the driver may have been connected to another computer,
> accessed by another driver, or accessed from userspace (say, VMWare doing
> a pass through driver).

So provide the FACILITY to reset the card, IFF it is needed. There are cases
where resetting the card is just stupid: don't force stupidity by design into
the kernel.

> I personally like the idea of having insmod/rmmod do copy-out/copy-in from
> a cache file in userspace.  That way, if we need large data sets (a ROM
> image for something.)  they don't take up kernel space when not in use.
> Also, it allows people to have persistant settings across reboot through
> the same mechanism--avoiding duplicating information in shutdown/startup 
> scripts.

I prefer the idea of the drivers which need this coming with a suitable
interface (/dev or /proc item) and a script to do this when needed.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
