Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTJMBpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 21:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTJMBpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 21:45:46 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:50073 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261346AbTJMBpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 21:45:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Mon, 13 Oct 2003 11:45:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16266.941.353643.513207@notabene.cse.unsw.edu.au>
Cc: Peter Osterlund <petero2@telia.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Johan Braennlund <spahmtrahp@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
In-Reply-To: message from Vojtech Pavlik on Sunday October 5
References: <16123.44602.150927.280989@gargle.gargle.HOWL>
	<1056699687.599.2.camel@teapot.felipe-alfaro.com>
	<16124.2893.587755.586343@gargle.gargle.HOWL>
	<m2smm7oc8s.fsf@p4.localdomain>
	<20031005171724.GA13141@ucw.cz>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 5, vojtech@suse.cz wrote:
> On Sun, Oct 05, 2003 at 06:55:31PM +0200, Peter Osterlund wrote:
>  
> > Hi!
> > 
> > I have updated your patch for kernel 2.6.0-test6-bk6 and made it
> > report events compatible with the synaptics touchpad kernel driver.
> > This should make it possible to use an ALPS device with the XFree86
> > synaptics driver:
> > 
> >         http://w1.894.telia.com/~u89404340/touchpad/index.html
> > 
> > Using this driver will give you edge scrolling and similar things.
> > 
> > I don't have an ALPS GlidePoint so I haven't been able to test this
> > patch at all. Test reports are appreciated. You probably need to
> > change a few parameters in the X configuration, like edge parameters
> > and finger pressure thresholds. Also note that the auto detection will
> > not work with an ALPS device, so you have to use Protocol="event" and
> > Device="/dev/input/eventN" for some value of N.
> 
> Very nice. Could you also make it a separate file? I think it's enough
> code to make that worth it ...

I would actually much rather not have this code in the kernel at all.
Given that I cannot find any documentation of the ALPS interface and
have no confidence of being able to detect an ALPS device or that
different ALPS devices behave the same way, I simply don't think this
stuff belongs in the kernel.

What I would much rather do is have /dev/psaux really be a char-dev
interface to the PS2 AUX port on the computer (rather than a faked
ps-aux look alike sythesised from all available mice) and have a
user-space program read that device, interpret it in a
user-configurable way, and send mouse events into /dev/input/uinput so
that other parts of the system see the appropriate moouse events.

I have code that does this but haven't had time to sort out a few
remaining little issues.

What I would *really* like to do is change /dev/psaux so that:
  If it is opened by user-space, it gets all chars from the AUX port,
  and input/mousedev doesn't see them.
  If it is not open, chars from /dev/psaux would bet processed by the
  current mouse driver.

Is there any chance that this might be accepted?

NeilBrown
