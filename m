Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135820AbRECRix>; Thu, 3 May 2001 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRECRio>; Thu, 3 May 2001 13:38:44 -0400
Received: from ch-12-44-141-183.lcisp.com ([12.44.141.183]:11525 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S135814AbRECRia>;
	Thu, 3 May 2001 13:38:30 -0400
Date: Thu, 3 May 2001 12:41:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.4 oops, will not boot
Message-ID: <20010503124141.A7237@debian-home.lcisp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AF13D85.4D8ADCFB@uow.edu.au>
User-Agent: Mutt/1.3.18i
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 09:14:13PM +1000, Andrew Morton wrote:
> From: Andrew Morton <andrewm@uow.edu.au>
> X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
> To: Gordon Sadler <gbsadler1@lcisp.com>
> Subject: Re: PROBLEM: 2.4.4 oops, will not boot
> 
> Gordon Sadler wrote:
> > 
> > On Thu, May 03, 2001 at 04:34:32PM +1000, Andrew Morton wrote:
> > > Gordon Sadler wrote:
> > > >
> > > > On Wed, May 02, 2001 at 09:51:39PM +1000, Andrew Morton wrote:
> > > > > Gordon Sadler wrote:
> > > > > >
> > > > > > Please CC on replies.
> > > > > > Attached is REPORTING-BUGS template from source, and a hand copied oops
> > > > > > that I ran through ksymoops. I really hope this is resolved, anything
> > > > > > further needed, just ask.
> > > > >
> > > > > Unfortunately the ksymoops output doesn't show the call trace.
> > > > > Can you please try again?  A reproducable oops is, err, rather
> > > > > important.  The syntax to feed into ksymoops is
> > > > >
> > > > > Call Trace: [<c0111234>] [<c0123456>] ...
> > > > >
> > > > > Thanks.
> > > > >
> > > > Right, I see the problem now.. s/Calltrace/Call Trace/
> > > >
> > > > Reran oops through ksymoops with change to Call Trace, output attached.
> > >
> > > Ugh.  Something seems to have corrupted your slab cache
> > > data structures, so this will be real hard to pin down.
> > >
> > > You could try setting DEBUG to 1 in mm/slab.c, see if
> > > that catches the culprit.
> > >
> > As requested.. changed config in one way, removed nvidia
> > framebuffer/replaced with vesa fb. After changeing DEBUG -> 1 in
> > mm/slab.c it produced 3 EIPs. I rebooted to 2.2.19, copied by hand, and
> > ran through ksymoops. The attached tar is the .config, hand copy of 3
> > EIPs, and the ouput from ksymoops.
> > 
> 
> Thanks for all the hard work :)
> 
> Something funny is happening at your end.  It's
> dying when it's trying to return a memory mapping
> control structure back to the memory management
> pool.  This code hasn't changed in a while, and
> if it was wrong, we'd be hearing it from lots of people.
> 
> Have you done a full rebuild? `make clean'?
> 
This last build of 2.4.4 with mod to mm/slab.c was a fresh unpack from a
src tarball from www.kernel.org. From what little I have gleaned from
this list, it appears a few others are having similar problems..
specifically I hear AMD CPU + Epox 8kta3 m/b will not boot with 3dnow
enabled? Some others have reported minor sucess with :
CONFIG_MK7=y
CONFIG_X86_USE_3DNOW=n

or they just compile with :
CONFIG_M686=y

I haven't seen any other ksymoops results from those individuals
however, and Alan Cox made a tentative analysis, it only happens with
VIA chipset -> VIA chipset bug.

I'm at a loss... I tried 2.4.4ac[23] both of them freeze during boot as
well, hmm... small idea: My BIOS allows FSB of 100/133 auto or manual
setting. I'm using pc100 SDRAM and the BIOS id's it as such at boot, any
chance the kernel is somehow trying to set something as though it were
133 FSB? 

Gordon Sadler


