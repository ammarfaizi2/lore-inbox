Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUHKSC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUHKSC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUHKR7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:59:36 -0400
Received: from mail1.kontent.de ([81.88.34.36]:34228 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268145AbUHKR4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:56:12 -0400
Date: Wed, 11 Aug 2004 19:56:13 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "David N. Welton" <davidw@eidetix.com>,
       LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040811175613.GA829@kenny.sha-bang.local>
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040811141408.17933.qmail@web81304.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:14:08AM -0700, Dmitry Torokhov wrote:
> Sorry for breaking the thread....
> 
> Sascha Wilde wrote:
> > On Wed, Aug 11, 2004 at 02:27:11PM +0200, Vojtech Pavlik wrote:
> > > On Wed, Aug 11, 2004 at 01:31:13AM -0500, Dmitry Torokhov wrote:
> > > > On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> > > > > By putting a series of 'crashme/reboot' calls into the kernel, I
> > > > > narrowed a possibl cause of it down to this bit of code in
> > > > > drivers/input/serio.c:753
> > [...]
> > > > Could you please try the patch below? I am interested in tests both
> > > > with and without keyboard/mouse. The main idea is to leave ports that
> > > > have been disabled by BIOS alone... The patch compiles but otherwise
> > > > untested. Against 2.6.7.
> > >
> > > Well, this has a problem - plugging a mouse later will never work, as
> > > the interface will be disabled by the BIOS if a mouse is not present at
> > > boot.
> > 
> > Is PS/2 supposed to support hotpluging at all?  I guess it's not, but I
> > may be wrong...
> 
> Yes it is, at least with newer (or rather not ancient) hardware...

well, so the patch obviously can't be a final solution...
 
> From what I can see 2.4 does not have this problem because before
> toucing the control register it tries to reset the keyboard and
> stops if there is not response. I think this also menas that 2.4
> does not support keyboard hot-plugging. In 2.6 we do not make any
> assumptions on what kind of hardware attached to a port (KBD, mouse)
> so reset test probably won't work...
> 
> I wonder if simply resetting controller (by passing i8042.reset)
> would help in your case?

It helps in a sense, as rebooting works with this option --
unfortunately when passing i8042.reset on boottime the keyboard is
dead, so it doesn't help.

cheers
-- 
Sascha Wilde
... mein Opa [...]  würde an dieser Stelle zu Dir sagen: Junge, such Dir 
ne Frau, bau Dir ein Haus, mach ein Kind und laß' die Finger von dem Zeug,
das Du gerade machst. -- Michael Winklhofer in d.a.e.auktionshaeuser
