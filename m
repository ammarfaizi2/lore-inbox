Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVKGUaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVKGUaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbVKGUaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:30:18 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:11534 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965226AbVKGUaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:30:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tpfscELy7kUnacNlSZU2yyHo6GVopSRx0QLXPbS7th+IB8aQQ96sVxbD25lIzCvQOKaDKrW5ly+Dc407mjFKLzw7yLyZtP1q69AiiBmGHRpzUj0swuGM7ANnv7i6BH39Ns5/uNn+TvD60JseyakO0mMko+SXMmOAHDEKvpL6IbQ=
Message-ID: <d120d5000511071230j20296d61w86254c62e2e95134@mail.gmail.com>
Date: Mon, 7 Nov 2005 15:30:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-mm1
Cc: Andrew Morton <akpm@osdl.org>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20051107200734.GD22524@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <436F7DAA.8070803@ums.usu.ru> <20051107115210.33e4f0bf.akpm@osdl.org>
	 <20051107200734.GD22524@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 07, 2005 at 11:52:10AM -0800, Andrew Morton wrote:
> > > 4) I also decided to test new input hotplug. Below is the udevmonitor
> > > trace of uevents when I rmmod and modprobe again the psmouse driver.
> > > <NULL>s don't look right there. Is the rest OK?
> > >
> > > UEVENT[1131378684] remove@/class/input/input1/mouse0
> > > ACTION=remove
> > > DEVPATH=/class/input/input1/mouse0
> > > SUBSYSTEM=input
> > > SEQNUM=903
> > > PHYSDEVPATH=/devices/platform/i8042/serio0
> > > PHYSDEVBUS=serio
> > > PHYSDEVDRIVER=psmouse
> > > MAJOR=13
> > > MINOR=32
> > >
> > > UEVENT[1131378684] remove@/class/input/input1
> > > ACTION=remove
> > > DEVPATH=/class/input/input1
> > > SUBSYSTEM=input
> > > SEQNUM=904
> > > PHYSDEVPATH=/devices/platform/i8042/serio0
> > > PHYSDEVBUS=serio
> > > PHYSDEVDRIVER=psmouse
> > > PRODUCT=11/2/4/0
> > > NAME="GenPS/2 Genius <NULL>"
> > > PHYS="isa0060/serio1/input0"
> > > UNIQ="<NULL>"
> > > EV=7
> > > KEY=1f0000 0 0 0 0 0 0 0 0
> > > REL=103
> >
> > Hopefully Greg can tell us?
>
> Those nulls are coming from the device's strings from what I have seen.
> I don't think this should be a problem, but Dmitry and Vojtech would
> know for sure.
>

input_hotplug() tests dev->phys but emits dev->uniq. I could swear I
fixed this typo at once already. Will prepare a patch tonight.

--
Dmitry
