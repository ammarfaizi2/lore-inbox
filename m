Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261941AbTC0MBS>; Thu, 27 Mar 2003 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbTC0MBS>; Thu, 27 Mar 2003 07:01:18 -0500
Received: from mail.ithnet.com ([217.64.64.8]:9999 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261941AbTC0MBQ>;
	Thu, 27 Mar 2003 07:01:16 -0500
Date: Thu, 27 Mar 2003 13:12:14 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Sykes <chris@sigsegv.plus.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-Id: <20030327131214.1dae4005.skraw@ithnet.com>
In-Reply-To: <20030327111600.GI2695@spackhandychoptubes.co.uk>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk>
	<20030326185236.GE24689@kroah.com>
	<20030326192520.GH2695@spackhandychoptubes.co.uk>
	<20030326193437.GI24689@kroah.com>
	<20030327111600.GI2695@spackhandychoptubes.co.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just wanted to hint that this very same BUG message appears on channel
bundling of ISDN, too. Greg, can you give a short description for this race
please, as I would like to find it in the ISDN-code, maybe your ideas help...

Thanks,
Stephan


On Thu, 27 Mar 2003 11:16:00 +0000
Chris Sykes <chris@sigsegv.plus.com> wrote:

> On Wed, Mar 26, 2003 at 11:34:37AM -0800, Greg KH wrote:
> > > Anyway I'll test out a 2.5 kernel when I'm back in the office
> > > tomorrow, I can devote some time to tracking down the problem if you
> > > can give me some pointers on where to start.  I'd like to be able to
> > > feel confident that this will work reliably under 2.4, otherwise I
> > > guess I need to look for alternate solutions.
> > 
> > The problem is in the race on close() in the usb-serial.c code.  In 2.5
> > that logic has been rewritten to (hopefully) get rid of the race.  That
> > is what will need to be backported, once people test that this fixes the
> > issue.
> 
> OK.  2.5.66 compiled and booted.
> 
> I've jumpered the hardware back to how it was originally when I
> experienced the problem.
> I've been working happily for about 10 mins with:
> 
> while /bin/true; do
>         for i in *; do
>                 cat $i >/dev/ttyUSB0
>         done
> done
> 
> No Oopsen or errors in dmesg as yet. (Before I was getting many errors
> about 0 size writes).
> 
> I can keep working under 2.5.66 for now to see if I experience any
> problems, but it would appear that the race is gone in 2.5.66
> (CONFIG_PREEMPT=y)
> 
> If you'd like me to try any patches against 2.4 just let me know.
> 
> Thanks again,
> 
> -- 
> 
> (o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
> //\       "Don't worry. Everything is getting nicely out of control ..."
> V_/_                          Douglas Adams - The Salmon of Doubt
> 
> 


-- 
MfG,
Stephan von Krawczynski
ith Kommunikationstechnik GmbH
