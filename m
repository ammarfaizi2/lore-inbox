Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUJHBSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUJHBSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269889AbUJGWzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:55:18 -0400
Received: from smtp09.auna.com ([62.81.186.19]:65248 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S267953AbUJGWbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:31:18 -0400
Date: Thu, 07 Oct 2004 22:31:14 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: PS2 mouse/kbd problems (gremlins?)
To: Andries Brouwer <aebr@win.tue.nl>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <1096998302l.5347l.0l@werewolf.able.es>
	<200410052332.34837.dtor_core@ameritech.net>
	<1097101822l.5054l.0l@werewolf.able.es>
	<20041007001017.GF4523@pclin040.win.tue.nl>
In-Reply-To: <20041007001017.GF4523@pclin040.win.tue.nl> (from
	aebr@win.tue.nl on Thu Oct  7 02:10:17 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097188274l.6408l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.07, Andries Brouwer wrote:
> On Wed, Oct 06, 2004 at 10:30:22PM +0000, J.A. Magallon wrote:
> > 
> > On 2004.10.06, Dmitry Torokhov wrote:
> > >On Tuesday 05 October 2004 12:45 pm, J.A. Magallon wrote:
> > >> Hi all...
> > >> 
> > >> I got time to track my ps2 problems. I run 2.6.9-rc2-mm[123] (that was
> > >> enough).
> > >> 
> > >> Results:
> > >> - mm1: mouse and kbd work ok, both in console and X
> > >> - mm2: mouse works, no kbd. I had to unplug/plug the keyboard to get it
> > >>   responding.
> > >> - mm3: kbd ok, but ps2 mouse is sluggish.
> > >> 
> > >> In latest -rc3-mm2, behavior is like mm3 and above.
> > >> 
> > >
> > >What about vanilla -rc3 and vanilla -rc3 with bk-input patch applied (if 
> > >you
> > >have some time of course). Do they exibit the same symptoms as -mm tree?
> > >
> > 
> > Both rc3 and rc3-bk.input work. Even rc3-mm2 works, depending on how I boot 
> > ;).
> > This is getting really strange....look:
> > 
> > lrwxrwxrwx  1 root root      21 2004.10.05 14:16 vmlinuz -> 
> > vmlinuz-2.6.9-rc3-mm2
> > 
> > lilo.conf:
> > default="linux"
> > append="psmouse.proto=exps"
> > image=/boot/vmlinuz
> >    label="linux"
> > ...
> > image=/boot/vmlinuz-2.6.9-rc3-mm2
> >    label="linux-2.6.9-rc3-mm2"
> > 
> > If I boot with the default entry, mouse does not work. If I boot with
> > the specific entry in lilo for rc3-mm2, it works.
> > 
> > dmesg diff:
> > -Kernel command line: BOOT_IMAGE=linux ro root=801 psmouse.proto=exps 3
> > +Kernel command line: BOOT_IMAGE=linux-2.6.9-rc3-mm2 ro root=801 
> > 
> > Somebody understands this ? Are there gremlins in my box ?
> 
> A week or so ago I had a problem and couldnt see which changeset
> caused it. After a binary search it turned out to be the changeset
> that changed the (length of the) kernel version string.
> A wild pointer was harmless at first, but after shifting everything
> by a few bytes it caused crashes.
> 
> Probably (hopefully) your problem is something entirely different,
> but it is not impossible that kernel behaviour depends on kernel name.

Well, partially solved...

I had USB legacy emulation active in the BIOS.  Disabling it makes
everything work as it should.

I had alwasy thought that Linux ignored the BIOS completely, as an
ancient remain of cr*p.

Thanks everyoune.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


