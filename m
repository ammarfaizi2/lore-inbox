Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbSLRV3G>; Wed, 18 Dec 2002 16:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbSLRV3G>; Wed, 18 Dec 2002 16:29:06 -0500
Received: from conductor.synapse.net ([199.84.54.18]:527 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S267347AbSLRV3D> convert rfc822-to-8bit; Wed, 18 Dec 2002 16:29:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Date: Wed, 18 Dec 2002 16:35:58 -0500
User-Agent: KMail/1.4.1
Cc: Manish Lachwani <manish@Zambeel.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10212180241580.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212181635.58164.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amendment to this email:
=====================
I figured out what it is, more...
hdparm -X12 ( to set PIO instead of UDMA ) /does not/ fix it, so I dug 
into BIOS and re-enabled the bios for that controller...

I'd disabled it because I've a SCSI burner that I use for backup
( DAR Disk ARchiver @ http://dar.linux.free.fr/  -- excellent program ),
as well as for installing distros, and I could not boot from the CD drive 
if the mobo was waiting for an OS to magically appear on whatever ATA 
device I had on the Promise-controller.  The BIOS is written to prevent 
one from choosing SCSI-boot and not Promise-boot while the Promise-BIOS 
is enabled, so I'd disabled it.
... when I re-enabled the Promise-BIOS, the problem disappeared.

So.  I /think/ that somehow the Promise controller isn't being 
initialized properly by the Linux kernel, UNLESS the mobo's BIOS inits 
it first?

============================
============================

Ah,
"What you are doing is not out of spec, just how
  you are are doing it is."
eh??

my typing in
hdparm -l /dev/hde ( upper-case Capital i ), or
smartctl -a, or
cat /proc/ide/hde/identify
are doing things wrong?
or do you mean that
 the method-used-by-these-commands is wrong somehow?

IF it'll get this fixed for everyone, then I'll sign an NDA ( probably: 
I'm reading it first, and discussing the NDA itself, too ), but I don't 
understand how NDA and GPL driver can mix?

I /want/ this fixed, because it's a problem, if for me, then for others 
too...

Does my having the "bios" for that controller turned off create the 
problem? ( I don't boot from those drives, so didn't see any reason to 
have it...  )
... hmmm I'll try changing that before contacting you again

One other weird thing is that when I've got my Quantum LM15 on the 
Promise, I've /got/ to have it on a 40-wire ribbon, or it doesn't work 
right ( can't remember if it fails to boot, or if the drive isn't 
accessable, or what )...
electronically the drive identifies as UDMA 4 or 5 or something, but if I 
put a UDMA cable on it it don't work ( solution? have a 40-wire cable on 
it, unless I've got it on the Via chipset port, in which case UDMA's 
fine... )

If you come-up-with, or have, a diagnostic that'd black-box 
reverse-engineer the bug, tell me, and I'll run it.

( note that now I'm using DAR
http://dar.linux.free.fr/
for backup, so I'm a /lot/ less worried than I used to be about hosing my 
system: the "backup your system" advice parroted always doesn't come 
with a good utility for doing so, but with DAR it's only 16 CD-Rs for 
the crucial stuff   : )   - just figured it's so good you'd benefit from 
knowing about it...   )


On Wed 18 December, 2002 5:44, Andre Hedrick wrote:
>Guess you two need to head over to promise and get those blood letting
>NDA's signed.  To figure out what is wrong with your deployment.
>I have never seen this issue and I know every combination of command
> calls to avoid.  What you are doing is not out of spec, just how you
> are are doing it is.
>
>Cheers,
>
>Andre Hedrick
>LAD Storage Consulting Group
>
>On Wed, 18 Dec 2002, D.A.M. Revok wrote:
>> Ahem.
>>
>> You /may/ want to remind me, next time, that umounting all
>> filesystems except root, remounting root read-only, AND raid-stop'ing
>> all arrays would be a good idea before doing this ( I forgot the last
>> one )
>>
>> Also, it seems that all drives de-allocate a sector every time I do
>> this, and this is costing my system integrity...
>>
>>
>> Yes, it happens on all drives on the controller, and I've 2:
>> IBM 60GXP, 40GB == /dev/hde
>> Quantum LM15, 15GB == /dev/hdg
>>
>> booting into multiuser command-line mode, no X, login as root, umount
>> everything, "smartctl -a /dev/hde" ( or hdg ) gets 2 information
>> lines, the second being the model# of the drive, and it never reaches
>> the third line ( the newline doesn't appear ), and the drive-light
>> comes on, and it's permanently hanged.
>>
>> I'd thought this would be implicit in the
>> * "cat /proc/ide/hde/identify" gets the same results *
>> comment I'd made previously, but did it out of curiosity...
>>
>>
>> When I did it on the Quantum, the Quantum's drive-light came on (
>> it's in a "mobile-rack" ), so it seems that the drive-light actually
>> is still connected to the drive at that point, though nothing useful
>> goes on after...
>>
>>
>> By the way, I seem to have hit this with the earlier 2.4.x kernels, (
>> IIRC ), but had /so/ much problems with flaky config and flaky
>> distros at the time, that I didn't get that info out then ( by the
>> time I got a stable system, I'd forgot, sorry... )
>>
>>
>> * Tell me which kernels you want me to try ( except ext3-broken ones
>> ), and I'll do it, so you can scope where-the-break-is better, TIA *
>>
>>      -me
>>
>> On Tue 17 December, 2002 7:09, you wrote:
>> >Is it happening with all the drives on the controller? Is it
>> > possible to immediaately gather the SMART data from the drive after
>> > bootup using smartctl?
>> >
>> >Thanks
>> >Manish
>> >
>> >-----Original Message-----
>>
>> From: D.A.M. Revok
>>
>> >To: linux-kernel@vger.kernel.org
>> >Sent: 12/15/02 12:49 PM
>> >Subject: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus
>> > A7V133 Promise ctrlr, or...
>> >
>> >( that's a capital-aye in the hdparm line )
>> >
>> >not even the Magic SysReq key will work.
>> >
>> >also, don't
>> >
>> >"cd /proc/ide/hde ; cat identify"
>> >
>> >... same thing
>> >drive-light comes on, but have to use the power-switch to get the
>> >machine
>> >back, ( lost stuff again, fuck )
>> >
>> >
>> >proc says it's pdc202xx
>> >
>> >Promise Ultra series driver Ver 1.20.0.7 2002-05-23
>> >Adapter: Ultra100 on M/B
>>
>> --
>> http://www.drawright.com/
>>  - "The New Drawing on the Right Side of the Brain" ( Betty Edwards,
>> check "Theory", "Gallery", and "Exercises" )
>> http://www.ldonline.org/ld_indepth/iep/seven_habits.html
>>  - "The 7 Habits of Highly Effective People" ( this site is same
>> principles as Covey's book )
>> http://www.eiconsortium.org/research/ei_theory_performance.htm
>>  - "Working With Emotional Intelligence" ( Goleman: this link is
>> /revised/ theory, "Working. . . " is practical )
>> http://www.leadershipnow.com/leadershop/1978-5.html
>>  - Corps Business: The 30 /Management Principles/ of the U.S. Marines
>> ( David Freedman )
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.drawright.com/
 - "The New Drawing on the Right Side of the Brain" ( Betty Edwards, 
check "Theory", "Gallery", and "Exercises" )
http://www.ldonline.org/ld_indepth/iep/seven_habits.html
 - "The 7 Habits of Highly Effective People" ( this site is same 
principles as Covey's book )
http://www.eiconsortium.org/research/ei_theory_performance.htm
 - "Working With Emotional Intelligence" ( Goleman: this link is 
/revised/ theory, "Working. . . " is practical )
http://www.leadershipnow.com/leadershop/1978-5.html
 - Corps Business: The 30 /Management Principles/ of the U.S. Marines ( 
David Freedman )


