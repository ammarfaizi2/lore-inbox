Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVCaQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVCaQcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVCaQcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:32:55 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:20743 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261407AbVCaQcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:32:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YpufE1OP2CP9kOx3lz83UBViwLiLOLwzcSxU1Ju6+3BmOVzNK7xrXCWEzRT9MsmPeCvj8a5BJgQV9o+VYUevhIxbjKwzNjgdqyvtEOtEgiODUEBlPM+NM5i7Cmbqu8oMKZZFi52PYmVMfZ7oFoYI8QhxvWaHC0oiD48FDmv93aI=
Message-ID: <d120d50005033108321c8f4ae7@mail.gmail.com>
Date: Thu, 31 Mar 2005 11:32:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329181831.GB8125@elf.ucw.cz>
	 <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
	 <20050329223519.GI8125@elf.ucw.cz>
	 <200503310226.03495.dtor_core@ameritech.net>
	 <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005 08:02:44 -0800 (PST), Patrick Mochel
<mochel@digitalimplant.org> wrote:
> 
> On Thu, 31 Mar 2005, Dmitry Torokhov wrote:
> 
> > Ok, what do you think about this one?
> >
> > ===================================================================
> >
> > swsusp: disable usermodehelper after generating memory snapshot and
> >         before resuming devices, so when device fails to resume we
> >         won't try to call hotplug - userspace stopped anyway.
> 
> Hm, shouldn't we disable it before we start to freeze processes? We don't
> want any more processes trying to start up after we've taken care of
> them..
> 

Can't a device be removed (for any reason) _while_ we are freezing
processes? I think freeszing code will properly deal with it... What
about suspend semantics - if suspend fails do we say the device should
be operational or the system should attempt to re-initialize? I.e. we
are not doing suspend after all - can we still drop messages on the
floor? After all, we still have ability to run coldplug after failed
suspend.

I frankly am not sure at what point to disable usermode helper. Or
maybe we need to have a list of pending events and suspend khelper_wq
while suspending.

-- 
Dmitry
