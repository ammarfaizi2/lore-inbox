Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVCYSg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVCYSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVCYSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:36:29 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:37491 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261736AbVCYSg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:36:26 -0500
Date: Fri, 25 Mar 2005 10:36:25 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>, dtor_core@ameritech.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050325183625.GA20993@hexapodia.org>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <20050325101344.GA1297@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325101344.GA1297@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 11:13:44AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > OK, anything else I should try?
> > 
> > not really, i just wait for Vojtech and Pavel :-)
> 
> Try commenting out "call_usermodehelper". If that helps, Stefan's
> theory is confirmed, and this waits for Vojtech to fix it.
> 
> > > wait_for_completion
> > > call_usermodehelper
> > > kobject_hotplug
> > > kobject_del

Without the call_usermodehelper in kobject_hotplug, the first suspend
seems to work OK (which I think confirms the theory).  But after resume,
the second suspend hangs in the same place.  It's calling
call_usermodehelper from input_call_hotplug... time to comment out
another one and recompile.

I also tried -mm1 and it hangs in the same place.

-andy
