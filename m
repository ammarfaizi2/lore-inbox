Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVC2Vg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVC2Vg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVC2VfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:35:00 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:53634 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261471AbVC2VdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:33:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tKDLIjpCiFfs5jvTkrSskTK1Xps1l3GAdCos4lSM4TiyIeTcQX2xUh7ppUiQ5v3+HaYLNT3aE18Mj6fLXm8WiPBGHVdX7v5/3C0NvVNkyr501Mh//K97lO71mlwhUQk4eaoYdPrEFIJx18iezDcUHt49w++aO++sXyNk2j35F7A=
Message-ID: <d120d50005032913331be39802@mail.gmail.com>
Date: Tue, 29 Mar 2005 16:33:04 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20050329211239.GG8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4243252D.6090206@suse.de> <4243D854.2010506@suse.de>
	 <d120d50005032908183b2f622e@mail.gmail.com>
	 <20050329181831.GB8125@elf.ucw.cz>
	 <d120d50005032911114fd2ea32@mail.gmail.com>
	 <20050329192339.GE8125@elf.ucw.cz>
	 <d120d50005032912051fee6e91@mail.gmail.com>
	 <20050329205225.GF8125@elf.ucw.cz>
	 <d120d500050329130714e1daaf@mail.gmail.com>
	 <20050329211239.GG8125@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 23:12:39 +0200, Pavel Machek <pavel@suse.cz> wrote:
> >
> > I am leaning towards calling disable_usermodehelper (not writtent yet)
> > after swsusp completes snapshotting memory. We really don't care about
> > hotplug events in this case and this will allow keeping "normal"
> > resume in drivers as is. What do you think?
> 
> That would certianly do the trick.
> 
> [Or perhaps in_suspend() is slightly nicer solution? People wanted it
> for other stuff (sanity checking, like BUG_ON(in_suspend())), too....]
> 

We might want having both... Hmm... in_suspend - is it only for swsusp
(in_swsusp) or for suspend-to-ram as well? For suspend to ram we might
need slightly different rules, I don't know. A separate call will
allow more fine-grained control and will explicitely tell reader what
is happening.

I do not have a strong preference though.

-- 
Dmitry
