Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310518AbSCKRoL>; Mon, 11 Mar 2002 12:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310523AbSCKRoD>; Mon, 11 Mar 2002 12:44:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57350
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310518AbSCKRnr>; Mon, 11 Mar 2002 12:43:47 -0500
Date: Mon, 11 Mar 2002 09:42:29 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <3C8CDA0D.7020703@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203110908220.10583-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am now sick of what I see and will now make a little noise!

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> Alan Cox wrote:
> >>   in replacements for CF cards in digital cameras and I would rather expect
> >>   them to be very tolerant about the driver in front of them. And then 
> >>
> > 
> > Oh dear me. Wrong again. Microdrives require proper polite wakeups. But you
> > see camera vendors buy in IDE code from people who can read and follow 
> > standards documents. 
> > 
> > 
> >>the WB
> >>   caches of IDE devices are not caches in the sense of a MESI cache, 
> >>they are
> >>   more like buffer caches and should therefore flush them self after s 
> >>short
> >>   period of inactivity without the application of any special flush 
> >>command.
> >>
> > 
> > You now have an absolute vote of *NO CONFIDENCE* on my part. I'm simply
> > not going to consider running your code. "It probably wont eat your disk"
> > and handwaving is not how you write a block layer.
> 
> You are claiming this repeatidly. But please just send me the f*cking
> strace and I will beleve you. Or point me at the corresponding docs.
> I see no special purpose Win2000 microdrive drivers on IBM.
> And I suppose you don't even *own* an IBM MicroDrive. And please
> note as well that I didn't tell: "I will never ever include such a
> thing if it's required". What I was about is that there is *no* reason
> to not include Pavels stuff, even if it leaks, which I know very well,
> some required functionality by now. Just to satisfy your imagination of how
> broken an implementation of the ATA firmware could be isn't a reaons.
> If you have a damn Micro Drive, then feel free to add the required wakeup code -
> you are all welcome. But please don't implement it as cat jksadfgkjhasdjkf >
> /proc/some/wried/stuff.
> 
> > How is anyone supposed to debug file system code in 2.5 when its known
> > that it will trash data on some disks anyway ? I'd like to see you cite
> > a paragraph where the IDE device is required to flush the data back
> > promptly, or on power off. I'd like to see what you plan to do about all
> > the IBM disks you plan to mistreat and give bad blocks that require a 
> > reformat ?
> 
> For gods sake:
> 
> 1. How is Win2000 going to work then?

If you are going to compare Linux to Mircosoft code you need to know what
the other side does.  Does reseting the bus between commands ring a bell?

Does the fact that MS XP Service Pack #2 having as similar taskfile
command passthrough method mean anything ... Oh Oh, but there is no
Service Pack #1 how could one know this ... guess my friend some of us are
in the business and you are trying to get there and I wish you success.

> 2. I assume (modulo mistakes) that writers of firmware
> are just not stupid and implement the cache as a write behind buffer and not
> as a MESI cache snooping on the drives bus. But I never claimed
> that I'm relying on this assumption in any way!

Sheesh, you are not even capable of reading the standard which I help to
co-author and mold.  It is a standard about "DEVICES" not about "HOSTS".
For a person citing MicroSoft Windows you are clueless to there erratium
about a HOST SHALL flush cache before a spin down.  Your darwin Linus
model is why WHQL exists for the other OS.

Were you ever a MDDK users?  It really sounds like it.

> 3. Why are *all the other* ATA drivers in different operating systems
> such easy on this matter and generally much simpler leaner and more
> readable then the Linux one?!
> 
> It's not like one couldn't compare... see for example www.ata-atapi.com

Funny Hale and I are friends, and I think he would laugh you off the
planet for your thoughts.  "YOU ARE A BAD HOST" is what I can hear in the
background.

> Fsck let's cite the IBM appilcation notes about the Micro Drive
> found here http://www.storage.ibm.com/hdd/micro/appguide.htm

Funny you should mention that point ... The "flagged taskfile code" is a
project to allow for NATIVE DFT support in Linux.  Nice screw job you did
to IBM.

> The IBM microdrive supports the write cache feature. When the write cache 
> feature is enabled, the
> microdrive posts a command completion for the write command as soon as all the 
> write data has
> been transferred to the microdrive's cache buffer. The host system, then, can 
> prepare for the next
> command while the microdrive performs actual disk writing off-line. The write 
> cache feature also
> contributes to the host system's battery life by shortening the amount of time 
> for write operation.

I bet you are clueless to MicroDrives having a new MetaData Cache set.
Goggle it, I am not going to teach you what you should know if you are
going to be a Maintainer.

> Because the write command completion does not correspond with the actual 
> disk-write completion,
> the host system is required to take special care not to lose supply power to the 
> microdrive so that the
> data that is cached but not yet written to disk will no be lost.

So what is your point, did you just figure this out.
FYI SCSI does this too but they have FUA.

> To ensure that the actual disk-writing of the cached data has been completed, it 
> is recommended that
> a host system issues a `Standby Immediate' command and waits for a command 
> complete from the
> microdrive.

Reread all of the document, all 500+ pages and figure out the rules
sequence, before you start trying to bible bang it.

> The cached data will be lost when :
>      1. A host system cuts off the power for the microdrive
>      2. A user ejects the microdrive
> before the microdrive completes writing cached data to disk.

Maybe that is why YOU and PAVEL are not getting this suspend to disk
write, you can not follow the rules.
ATA-ATAPI ~= LINUS, it is a DICTATORSHIP also.  If you can not follow the
rules you get ABORTED, or CORRUPTED.  What part is not clear?
See I got aborted by Linus, you have been corrupted.

> The microdrive cleans (flushes out) whole cached data upon command completion of 
> Standby Immediate. If
> the host system enables the write cache feature, it is strongly recommended to 
> issue Standby Immediate
> before power removed, system shutdown or ejection of the microdrive.

> The write cache feature is disabled at power-on reset. It is possible for the 
> host system to enable this feature
> by issuing Set Features (Enable Write Cache). Because the microdrive may be used 
> with a host system
> without such care for data integrity, IBM insists that the write cache feature 
> should not be a power-on default.
> 
>   * Consideration for a time-out value when using the write cache

Well of it does not complete you do not let the suspend complete and you
give ACPI the finger and provide the enduser a way to override the
ruleset.  Let ROOT screw the system, but be a "GOOD HOST" and prevent it
by default.

> The microdrive can queue several consecutive write commands. Even if the host 
> system receives a
> command completion, the microdrive may still be performing disk writing for 
> queued commands, each of
> which could take up to 7.5 seconds as previously mentioned if an error has 
> occurred and an error
> recovery routine starts.
> This delay eventually surfaces when processing a first non-queued command during 
> write cache.

WTF are you talking about ?? TCQ ?? Go and whiteboard it and you will see
the problem.  If you are talking about write cache, all drives do this and
the point again was ??

> For example, suppose the microdrive queues 2 write commands and each command 
> takes 7.5 seconds
> for some extreme reason. Then if the microdrive receives Read Sectors, which is 
> a non-queue command,
> it will be processed just after disk writing is completed.  In the worst case, 
> delay for the Read Sectors
> would be close to 15 seconds (7.5 x 2).

How are you going to delay commands unless metadata hardware cache is
used?

> In light of the stuation above,  IBM recommends 30 seconds as a time-out value 
> if the host system uses
> the write cache feature.

The SPEC does does not address CFA hardware, goto CFA to get their ruleset.

> And apparently we see that there is nothing special about them... Just don't
> enable the write cache and all should be well with a timeout of 30 seconds.

Well it is safer than what you are mumbling about.

Linus you learn anything yet, either?


Andre Hedrick
The Second Linux X-IDE guy

