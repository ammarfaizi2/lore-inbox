Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUAUMrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUAUMrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:47:04 -0500
Received: from ns.suse.de ([195.135.220.2]:21198 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265959AbUAUMq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:46:59 -0500
Date: Wed, 21 Jan 2004 13:46:57 +0100
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
Message-Id: <20040121134657.6cd27cbd.ak@suse.de>
In-Reply-To: <20040121123454.GB538@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de>
	<20040121043608.6E4BB2C0CB@lists.samba.org>
	<20040121084009.GC295@ucw.cz>
	<20040121132744.1094129f.ak@suse.de>
	<20040121123454.GB538@ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004 13:34:54 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Wed, Jan 21, 2004 at 01:27:44PM +0100, Andi Kleen wrote:
> > On Wed, 21 Jan 2004 09:40:09 +0100
> > Vojtech Pavlik <vojtech@suse.cz> wrote:
> > 
> > > 
> > > Inbetween the module changes and the input changes there was a
> > > situation, where you'd have to pass
> > > 
> > > 	psmouse.psmouse_maxproto=imps2
> > > 
> > > as a kernel argument. This should (I hope so, I have to check) be fixed
> > > now.
> > 
> > No, 2.6.1 requires it.
> > 
> > And worst is that you have to reboot to change mouse settings at all.
> > That just doesn't make any sense. Can you please add an runtime sysfs
> > interface for this?
> 
> It's planned, though not easy to implement at all. I don't think I'll be
> able to get this into 2.6.2. For now you can enable EMBEDDED, compile
> psmouse as a module, and just rmmod/insmod it with new parameters.

Really. I don't want a modular mouse driver, just a mouse that keeps working
over kernel releases without me requiring tracking undocumented changes
every release. Thanks for the warning that you renamed it again, at least
that will save some reboots next time.

Could you perhaps readd the old __setup that at least the old version
keeps working? After that you can rename it again as often as you
want as long as the old alias keeps working ;-)

As for the implementation of doing it at runtime - i took a look at it
but got scared by sysfs livetime rules and the lack of callbacks in module_parm. 
I think the easiest way would be to just poll the value: make it a module_parm with the 
w bit enabled, add a second set of state variables and every time you access 
the mouse you compare the module_parm variables and the shadow variables and change
the mouse setting if they differ. Not pretty, but would probably work without
too much sysfs black magic.

-Andi

>
