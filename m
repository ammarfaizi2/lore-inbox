Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUHJHEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUHJHEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267453AbUHJHEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:04:50 -0400
Received: from c66-235-4-168.sea2.cablespeed.com ([66.235.4.168]:57836 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id S267451AbUHJHEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:04:47 -0400
Date: Tue, 10 Aug 2004 00:02:26 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810070226.GA10993@darklands>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org> <1092099669.5759.283.camel@cube> <cone.1092113232.42936.29067.502@pc.kolivas.org> <1092106283.5761.304.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092106283.5761.304.camel@cube>
X-Operating-System: Linux darklands 2.6.8-rc1-ck5-amd64
X-Operating-Status: 10:22:29 up 7 min,  4 users,  load average: 1.68, 0.84, 0.34
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Aug 10:51, Albert Cahalan wrote:
> On Tue, 2004-08-10 at 00:47, Con Kolivas wrote:
> > Albert Cahalan writes:
> > > On Mon, 2004-08-09 at 18:59, Con Kolivas wrote:
> > >> Albert Cahalan writes:
> 
> > >> > Joerg:
> > >> >    "WARNING: Cannot do mlockall(2).\n"
> > >> >    "WARNING: This causes a high risk for buffer underruns.\n"
> > >> > Fixed:
> > >> >    "Warning: You don't have permission to lock memory.\n"
> > >> >    "         If the computer is not idle, the CD may be ruined.\n"
> > >> > 
> > >> > Joerg:
> > >> >    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
> > >> >    "WARNING: This causes a high risk for buffer underruns.\n"
> > >> > Fixed:
> > >> >    "Warning: You don't have permission to hog the CPU.\n"
> > >> >    "         If the computer is not idle, the CD may be ruined.\n"
> > >> 
> > >> Huh? That can't be right. Every cd burner this side of the 21st century has 
> > >> buffer underrun protection.
> > > 
> > > I'm pretty sure my FireWire CD-RW/CD-R is from
> > > another century. Not that it's unusual in 2004.
> > > 
> > >> I've burnt cds _while_ capturing and encoding 
> > >> video using truckloads of cpu and I/O without superuser privileges, had all 
> > >> the cdrecord warnings and didn't have a buffer underrun.
> > > 
> > > That's cool. My hardware won't come close to that.
> > > Burning a coaster costs money.
> > > 
> > > Let me put it this way: $$ $ $$$ $$ $ $$$ $$ $
> > > 
> > > The warning, if re-worded, will save people from
> > > frustration and wasted money.
> > 
> > Sounds good; how about something less terrifying? That warning sounds like a 
> > ruined cd is likely.
> 
> I'm not about to burn CDs trying, but I do believe
> that "a ruined cd is likely" would be accurate if I
> were to keep busy with Mozilla and such. OpenOffice
> would surely ruin a cd. Light web browsing makes my
> mp3 player skip.
> 
> Not all of us have hardware like you do. Encoding
> video is something I wouldn't bother to try, even
> without the CD burner going!
> 
> (the box isn't that old; it's fanless though)
> 

I've only created coaster _with_ the suid bit while ab^H^Husing the 
computer to do other things--like compiling a new kernel. 2.6 is much
better at setting up DMA access to the drive; 2.4 would use huge amounts
of system time (> 90%). When that happened, the system felt like it was 
out to lunch--mouse cursor updates would sometimes take >2 seconds. 
Cdrecord used more cpu if it was suid. I haven't had a problem in 2.6.
The  warning is counter to my expericnce with cdrecord. I think the
warning would be worded better as:

"Warning: Cdrecord was unable to get exclusive access to the cpu."
"Warning: This may cause Buffer underruns from other activity."

and

"Warning: Cdrecord was unable to get exclusive access to memory."
"Warning: This may cause Buffer underruns from other activity."

But drop the first one if you're on >2.6.

Thomas
