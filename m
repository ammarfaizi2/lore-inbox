Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUE3QQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUE3QQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUE3QQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:16:38 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:14680 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264044AbUE3QQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:16:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Sun, 30 May 2004 11:16:31 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>, tuukkat@ee.oulu.fi
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <200405301009.21202.dtor_core@ameritech.net> <20040530155821.GC1479@ucw.cz>
In-Reply-To: <20040530155821.GC1479@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301116.31356.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 10:58 am, Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 10:09:18AM -0500, Dmitry Torokhov wrote:
> 
> > On Sunday 30 May 2004 08:42 am, Vojtech Pavlik wrote:
> > > 
> > > Anyway, looking at the patch, it's not bad, and it's quite close to what
> > > I was considering to write. I'd like to keep it separate from the
> > > serio.c file, although it's obvious it'll require to be linked to it
> > > statically, because it needs hooks there - it cannot be a regular serio
> > > driver.
> > > 
> > 
> > Do we really have to have this stuff directly in serio? How about being able
> > to mark some serio ports as working in raw mode (i8042.raw=0,1,1,0) and have
> > separate (serio_raw?) module bind to such ports
> 
> We don't have to. But it'd be rather convenient to have it. It would
> work for all serio ports, not just i8042, etc, etc.
> 
> And if kept in a separate file (serio-dev.c), it wouldn't mess up things
> too much.
> 

Well, my argument is that we only have immediate need for raw access to 
PC-style AUX ports because of wide variety of connected devices. Serial
ports have other historical means of accessing them, busmice ports have
well known devices attached.

Once we have sysfs integration in place I imagine we will be able to
implement dynamic binding of serio drivers and ports, atkbd and psmouse
being default ones and user will be able to rebind a specific port to
let's say serio-raw or some other driver that does not have automatic
hardware detection yet.

But in the meantime marking several ports raw will allow most of the users
use old means of communicating with their pointing devices without too
much effort.
 
-- 
Dmitry
