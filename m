Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUJ0Aec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUJ0Aec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUJ0Aec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:34:32 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:8106 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261537AbUJ0Ad5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:33:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
Date: Tue, 26 Oct 2004 19:33:50 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Kim Holviala <kim@holviala.com>,
       vojtech@suse.cz
References: <417E0EA8.7000704@holviala.com> <20041026171157.21c7a15a.akpm@osdl.org>
In-Reply-To: <20041026171157.21c7a15a.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410261933.50544.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 07:11 pm, Andrew Morton wrote:
> Kim Holviala <kim@holviala.com> wrote:
> >
> > The scrollwheel thingy (stick) on IBM ScrollPoint mice returns extremely
> > aggressive values even when touched lightly. This confuses XFree which
> > assumes the wheel values can only be 1 or -1. Incidently, it also
> > confuses Windows' default mouse driver which proves the problem is in
> > the mouse itself.
> > 
> > This patch limits the scroll wheel movements to be either +1 or -1 on
> > the event -> emulated PS/2 level. I chose to implement it there because
> > mousedev emulates Microsoft mice but the real ones almoust never return
> > a bigger value than 1 (or -1).
> > ...
> > +#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
> > +				if (value) { value = (value < 0 ? -1 : 1); }
> > +#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
> 
> This is really not a thing which we can put behind compile-time config.
> 
> Can we come up with a fix which works correctly on all hardware?  If not,
> this workaround will need to be enabled by some sort of runtime detection.
> 

Unless someone (Vojtech?) has an objection I think we should always have
this workaround activated - after all mousedev provides legacy emulation
mostly for XFree/XOrg benefit anyway. Clients accessing data through evdev
will see the full picture regardless.

-- 
Dmitry
