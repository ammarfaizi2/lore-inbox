Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbRCIALE>; Thu, 8 Mar 2001 19:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRCIAKz>; Thu, 8 Mar 2001 19:10:55 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:11019 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S130329AbRCIAKq>;
	Thu, 8 Mar 2001 19:10:46 -0500
Date: Thu, 8 Mar 2001 16:07:58 -0800
From: Greg KH <greg@kroah.com>
To: Erik DeBill <edebill@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
Message-ID: <20010308160758.A16296@kroah.com>
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu> <20010307172056.A8647@austin.rr.com> <20010307173640.A14818@kroah.com> <20010308140103.A17993@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010308140103.A17993@austin.rr.com>; from edebill@swbell.net on Thu, Mar 08, 2001 at 02:01:03PM -0600
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 02:01:03PM -0600, Erik DeBill wrote:
> On Wed, Mar 07, 2001 at 05:36:40PM -0800, Greg KH wrote:
> > I'll try to run with everything compiled into the kernel later tonight.
> > Does -ac14 with all of USB as modules, using usb-uhci work for you?
> 
> Hmm... I was compiling usb-uhci and uhci directly into the kernel,
> then visor.o as a module.

You shouldn't be able to compile both usb-uhci and uhci into the kernel,
unless you tweak your .config file by hand.

> ac13 + crypto works with usb-uhci, usb-serial, and visor as modules.
> No problems.
> 
> I've gone back and (re)tested with kernels 2.4.1, 2.4.2, ac[36],
> ac1[01234].  I can only get a crash on ac12 and ac13.  2.4.2 is broken
> after all, and everything after it.  2.4.2 and the ac kernels seem to
> fail on 'pilot-xfer /dev/usb/tts/1 -m scsi.pdb' (to install a zTXT
> into gutenpalm, doesn't matter what I'm sending), and things seem to
> go slower and have more problems as the versions increase.  Then I can
> crash the system under ac12 and 13.  This is using uhci compiled
> directly into kernel, with usb-serial and visor as modules.

What is the oops from when things crash?
Have you tried enabling debugging on the usb-serial drivers and looking
at what the visor driver spits out to the kernel debug log?  I'd be
interested in seeing that.

Since you are reporting problems with a clean 2.4.2 kernel, I don't
think that the 1 line patch in ac12 is the cause of your problem.

What kind of hardware is this?  What compiler?  What version of
modutils?  What is your .config?  Do you have any other USB devices that
work properly (or not) in this system?  Have you tried resetting your
Visor?

> If uhci + visor is unsupported, might I suggest the following change
> to Configure.help to warn people?

I've considered it, but I keep hoping that JE is going to fix the uhci
driver some day soon :)

There are other drivers that also do not work with the uhci.o driver do
to this bug.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
