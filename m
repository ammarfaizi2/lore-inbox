Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVC2VpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVC2VpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVC2VpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:45:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27284 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261461AbVC2VoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:44:25 -0500
Date: Tue, 29 Mar 2005 23:44:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050329214408.GH8125@elf.ucw.cz>
References: <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com> <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com> <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com> <20050329205225.GF8125@elf.ucw.cz> <d120d500050329130714e1daaf@mail.gmail.com> <20050329211239.GG8125@elf.ucw.cz> <d120d50005032913331be39802@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d120d50005032913331be39802@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 29-03-05 16:33:04, Dmitry Torokhov wrote:
> On Tue, 29 Mar 2005 23:12:39 +0200, Pavel Machek <pavel@suse.cz> wrote:
> > >
> > > I am leaning towards calling disable_usermodehelper (not writtent yet)
> > > after swsusp completes snapshotting memory. We really don't care about
> > > hotplug events in this case and this will allow keeping "normal"
> > > resume in drivers as is. What do you think?
> > 
> > That would certianly do the trick.
> > 
> > [Or perhaps in_suspend() is slightly nicer solution? People wanted it
> > for other stuff (sanity checking, like BUG_ON(in_suspend())), too....]
> > 
> 
> We might want having both... Hmm... in_suspend - is it only for swsusp
> (in_swsusp) or for suspend-to-ram as well? For suspend to ram we might
> need slightly different rules, I don't know. A separate call will
> allow more fine-grained control and will explicitely tell reader what
> is happening.

We currently freeze processes for suspend-to-ram, too. I guess that
disable_usermodehelper is probably better and that in_suspend() should
only be used for sanity checks... go with disable_usermodehelper and
sorry for the noise.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
