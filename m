Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUJ0Fv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUJ0Fv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUJ0Fv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:51:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1664 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S261658AbUJ0FvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:51:03 -0400
Date: Wed, 27 Oct 2004 07:51:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kim Holviala <kim@holviala.com>
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
Message-ID: <20041027055059.GB1211@ucw.cz>
References: <417E0EA8.7000704@holviala.com> <20041026171157.21c7a15a.akpm@osdl.org> <200410261933.50544.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410261933.50544.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 07:33:50PM -0500, Dmitry Torokhov wrote:

> > > This patch limits the scroll wheel movements to be either +1 or -1 on
> > > the event -> emulated PS/2 level. I chose to implement it there because
> > > mousedev emulates Microsoft mice but the real ones almoust never return
> > > a bigger value than 1 (or -1).
> > > ...
> > > +#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
> > > +				if (value) { value = (value < 0 ? -1 : 1); }
> > > +#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
> > 
> > This is really not a thing which we can put behind compile-time config.
> > 
> > Can we come up with a fix which works correctly on all hardware?  If not,
> > this workaround will need to be enabled by some sort of runtime detection.
> > 
> 
> Unless someone (Vojtech?) has an objection I think we should always have
> this workaround activated - after all mousedev provides legacy emulation
> mostly for XFree/XOrg benefit anyway. Clients accessing data through evdev
> will see the full picture regardless.
 
We can have a workaround for XOrg, but not one like this. This will make
fast scrolling unreliable. I have standard Microsoft-compatible mice
which do report more than one scroll tick per report, if you scroll the
wheel fast enough, and this throws away the extra ticks.

We would have to split the value into multiple events which would each
report a 1 or -1.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
