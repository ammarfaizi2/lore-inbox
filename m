Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUJ0GcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUJ0GcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbUJ0GbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:31:15 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:45690 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262222AbUJ0G3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:29:54 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
Date: Wed, 27 Oct 2004 01:29:49 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Kim Holviala <kim@holviala.com>
References: <417E0EA8.7000704@holviala.com> <200410261933.50544.dtor_core@ameritech.net> <20041027055059.GB1211@ucw.cz>
In-Reply-To: <20041027055059.GB1211@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270129.49255.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 12:51 am, Vojtech Pavlik wrote:
> On Tue, Oct 26, 2004 at 07:33:50PM -0500, Dmitry Torokhov wrote:
> 
> > > > This patch limits the scroll wheel movements to be either +1 or -1 on
> > > > the event -> emulated PS/2 level. I chose to implement it there because
> > > > mousedev emulates Microsoft mice but the real ones almoust never return
> > > > a bigger value than 1 (or -1).
> > > > ...
> > > > +#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
> > > > +				if (value) { value = (value < 0 ? -1 : 1); }
> > > > +#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
> > > 
> > > This is really not a thing which we can put behind compile-time config.
> > > 
> > > Can we come up with a fix which works correctly on all hardware?  If not,
> > > this workaround will need to be enabled by some sort of runtime detection.
> > > 
> > 
> > Unless someone (Vojtech?) has an objection I think we should always have
> > this workaround activated - after all mousedev provides legacy emulation
> > mostly for XFree/XOrg benefit anyway. Clients accessing data through evdev
> > will see the full picture regardless.
>  
> We can have a workaround for XOrg, but not one like this. This will make
> fast scrolling unreliable. I have standard Microsoft-compatible mice
> which do report more than one scroll tick per report, if you scroll the
> wheel fast enough, and this throws away the extra ticks.
> 
> We would have to split the value into multiple events which would each
> report a 1 or -1.
> 

I have taken a look at XFree/XOrg sources and it seems that they should
not have -1/1 problem but values outside of limits allowed for Intellimouse
or Explorer protocols will cause re-evaluation of protocol mode. We probably
just clamp values to protocol limits (-8/+7 for intellimouse and explorer
modes) and be done with it.

-- 
Dmitry
