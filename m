Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUHKOOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUHKOOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUHKOOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:14:12 -0400
Received: from web81304.mail.yahoo.com ([206.190.37.79]:61273 "HELO
	web81304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268036AbUHKOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:14:08 -0400
Message-ID: <20040811141408.17933.qmail@web81304.mail.yahoo.com>
Date: Wed, 11 Aug 2004 07:14:08 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
To: Sascha Wilde <wilde@sha-bang.de>
Cc: "David N. Welton" <davidw@eidetix.com>,
       LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for breaking the thread....

Sascha Wilde wrote:
> On Wed, Aug 11, 2004 at 02:27:11PM +0200, Vojtech Pavlik wrote:
> > On Wed, Aug 11, 2004 at 01:31:13AM -0500, Dmitry Torokhov wrote:
> > > On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> > > > By putting a series of 'crashme/reboot' calls into the kernel, I
> > > > narrowed a possibl cause of it down to this bit of code in
> > > > drivers/input/serio.c:753
> [...]
> > > Could you please try the patch below? I am interested in tests both
> > > with and without keyboard/mouse. The main idea is to leave ports that
> > > have been disabled by BIOS alone... The patch compiles but otherwise
> > > untested. Against 2.6.7.
> >
> > Well, this has a problem - plugging a mouse later will never work, as
> > the interface will be disabled by the BIOS if a mouse is not present at
> > boot.
> 
> Is PS/2 supposed to support hotpluging at all?  I guess it's not, but I
> may be wrong...

Yes it is, at least with newer (or rather not ancient) hardware...

>From what I can see 2.4 does not have this problem because before
toucing the control register it tries to reset the keyboard and
stops if there is not response. I think this also menas that 2.4
does not support keyboard hot-plugging. In 2.6 we do not make any
assumptions on what kind of hardware attached to a port (KBD, mouse)
so reset test probably won't work...

I wonder if simply resetting controller (by passing i8042.reset)
would help in your case?

--
Dmitry
