Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRIFNlF>; Thu, 6 Sep 2001 09:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRIFNk4>; Thu, 6 Sep 2001 09:40:56 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:44552 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S270795AbRIFNkm>; Thu, 6 Sep 2001 09:40:42 -0400
Message-ID: <3B97729B.1F49AACA@namesys.com>
Date: Thu, 06 Sep 2001 16:56:59 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Mack Stevenson <mackstevenson@hotmail.com>
CC: linux-kernel@vger.kernel.org, _deepfire@mail.ru,
        Chris Mason <mason@suse.com>, Edward Shushkin <edward@mail.infotel.ru>
Subject: Re: Basic reiserfs question
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we should put something in journal replay that says:

"Warning: replaying a non-empty journal, this means that either your system
crashed, or its shutdown scripts need fixing (a common distro failing at the
moment), or you pushed the power button.  Don't use the hardware power button to
turn your computer off before telling the operating system software to halt
(there exists a 'halt' command you can use), the risk in doing so is that the
files you or your software were writing to at the time you pushed the button can
have garbage added to them."

Chris, do you agree?  Edward, please make this change and create a patch.

Of course, now that the distros have turned off all those annoying messages from
the kernel, most users will never see this, sigh.  I think it is a real problem
that the distros have turned off the messages at boot time....

Hans


Mack Stevenson wrote:
> 
> >Mack Stevenson wrote:
> > >
> > > I would like to know whether log replays take place whenever the system
> >is
> > > booted or only after it has been incorrectly shutdown. I occasionaly see
> > > "Warning, log replay (...)" during the boot-up sequence although the
> >system
> > > had been correctly shut down, and I would like to know if I should
> >worry.
> 
> >From: Hans Reiser <reiser@namesys.com>
> >To: Mack Stevenson <mackstevenson@hotmail.com>
> >CC: linux-kernel@vger.kernel.org
> >Subject: Re: Basic reiserfs question
> >Date: Thu, 06 Sep 2001 01:50:59 +0400
> >
> >
> >Are you using redhat?  Do your shutdown scripts unmount the filesystem only
> >if
> >it is ext2?
> 
> I am using slackware (8.0), and the shutdown script on my system uses:
> 
> # Turn off swap, then unmount local file systems.
> echo "Turning off swap."
> swapoff -a
> echo "Unmounting local file systems."
> # Don't remount UMSDOS root volumes:
> if [ ! "`mount | head -1 | cut -d ' ' -f 5`" = "umsdos" ]; then
>   umount -a -r -t nonfs
>   echo "Remounting root filesystem read-only."
>   mount -n -o remount,ro /
> else
>   umount -a -r -t nonfs,noumsdos,nosmbfs
> fi
> 
> # This never hurts:
> sync
> 
> ---
> 
> I guess that's not the probem, then... Actually, whenever I shutdown I never
> see any messages about the unmounting (or the mounting in readonly mode)
> failing, which only adds to my confusion.
> 
> >From: Samium Gromoff <_deepfire@mail.ru>
> >To: linux-kernel@vger.kernel.org
> >CC: mackstevenson@hotmail.com
> >Subject: Re: Basic reiserfs question
> >Date: Thu, 6 Sep 2001 03:35:49 +0000 (UTC)
> >
> >Actually you see "Warning" only when it is replaying log on
> >fs mounted readonly.
> 
> Yes, that's the warning I see.
> 
> >I wander though why you see it only "occasionally"..
> >Normally it replays log every time and you shouldnt bother.
> 
> Does it? I know next to nothing about these issues, but I thought that I had
> read somewhere that log replays only occurred after a system crashed and
> couldn't be shutdown properly.
> 
> Thank you both,
> 
> Mack S.
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
