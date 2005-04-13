Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVDMX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDMX2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDMX2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:28:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261223AbVDMX2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:28:33 -0400
Date: Wed, 13 Apr 2005 19:28:26 -0400
From: Dave Jones <davej@redhat.com>
To: Ross Biro <ross.biro@gmail.com>
Cc: Andi Kleen <ak@muc.de>, Ross Biro <rossb@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Message-ID: <20050413232826.GA22698@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ross Biro <ross.biro@gmail.com>, Andi Kleen <ak@muc.de>,
	Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com> <20050413183725.GG50241@muc.de> <8783be66050413160033e6283d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783be66050413160033e6283d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 07:00:06PM -0400, Ross Biro wrote:

 > > If you take a look at quirks.c and DMI options you will see we have quite a lot
 > > of workarounds for various hardware bug. Just imagine there were
 > > CONFIG options for all of this. It would be a big mess!
 > 
 >  The config option is for distro maintainers to use to set a policy
 > for their particular distribution.  The boot line option is for end
 > users to adjust it.  Last I heard, most distro makers compile their
 > own kernels and select options appropriately.  I really don't think
 > it's too much to ask an end user to adjust their grub.conf or
 > lilo.conf file to work around a bug in their hardware, especially
 > since their is *no way* to work around the bug in all cases with out
 > user intervention.

The thing is, most users won't have a clue about this option,
and that is a good thing. They just want stuff to work, not have
to poke random bits and pieces.

 > As I said before, the quirks routines cannot handle it since there is
 > no way to know what the correct setting is unless you know what
 > application is going to be run and what the users tolerance to
 > particular problems is.  In a perfect world, master abort mode would
 > always be set to on, but that is not practical in the real world.  If
 > you are suggesting that something in the quirks file stop the boot and
 > ask the user some questions about how they intend to use the system
 > and what their tolerance for certain types of errors is, then I think
 > you are suggesting an even bigger mess.

You don't need to ask the user anything (they won't know the answers anyway)
You already mentioned that E1000's cause this problem, so you have the
basis for the beginning of a blacklist.  A patch to explicitly enable
this feature in -mm for a while will probably shake out most of the
common problematic hardware pretty quickly.

 > Someone creating a dstro for enterprise use would most likely compile
 > the kernel with master abort mode enabled to prevent silent data loss.
 >  Someone building the system for desktop use would choose either
 > default or disabled, to prevent spurious error messages, or hardware
 > lock ups. 

So its ok for enterprise use to spew error msgs and have hardware lockups ?
See the problem with setting it either on/off ? We need to take
additional factors into consideration, or we're left with something
thats essentially useless.
 
 > If users report problems that look like they are caused by
 > the master abort mode setting, a tech support person could easily ask
 > the end user to add a boot time command line option to see if the
 > problem goes away.  The end user would then have the *option* of
 > adjusting the config file, or just using the boot time option.

A lock-up could be caused by any number of problems, and I'll put money
on even the best support guys not knowing about this option 6 months
after it got merged. Obscure toggles for esoteric features like this
get forgotten about quickly. It's more likely the support bod would
chase down other avenues before ever hitting upon this.

 > I would aggree with you if it were not for the fact that the correct
 > setting of this bit is really a judgement call, so it must be simple
 > for anyone who needs to make the call to be able to.  The people
 > building distors will need to be able change the default setting
 > easily at compile time and the end user needs to be able to change the
 > setting at boot time or run time.

As someone who builds distro kernels I disagree.
End users need things to 'just work'. 99% of end-users don't know, or care
about quirks in their hardware.  If we start expecting the bulk of
them to have to go editing their grub/lilo/etc configs, we've lost.

 > Someone on the PCI mailing list has suggested that it is enough to let
 > the distro maintainer edit the header file and adjust the setting
 > there.  To do so would mean that many distro maintainers would have to
 > maintain an additional patch for very little reason.  Perhaps the
 > correct solution is to keep it as a config option and add a
 > CONFIG_OBSCURE so that most people don't ever see option, but the few
 > that need to can.

If we have a situation where we screw a subset of users with the
config option =y and a different subset with =n, how is this improving
the situation any over what we have today ?

		Dave

