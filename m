Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWBUVkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWBUVkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWBUVk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:40:27 -0500
Received: from styx.suse.cz ([82.119.242.94]:40167 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964830AbWBUVkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:40:25 -0500
Date: Tue, 21 Feb 2006 22:40:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
Subject: Re: Suppressing softrepeat
Message-ID: <20060221214030.GA12575@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com> <20060221210800.GA12102@suse.cz> <d120d5000602211332p16381c16t100f93116cd33539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000602211332p16381c16t100f93116cd33539@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 04:32:21PM -0500, Dmitry Torokhov wrote:
> On 2/21/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Feb 21, 2006 at 12:43:08PM -0800, Pete Zaitcev wrote:
> >
> > > Add the "nosoftrepeat" parameter. This is useful if a "dumb" keyboard
> > > has (unswitcheable) hardware repeat, like in Dell DRAC3.
> >
> > The softrepeat code should properly ignore all autorepeated keys from a
> > 'dumb' keyboard. It's rather common that a keyboard we can't communicate
> > with is in autorepeat mode, because that's the mode AT keyboards wake up
> > in after power on.
> 
> Hmm, atkbd only detects "repeated" keystrokes if it is working in
> hard-repeat mode:
> 
>         value = atkbd->release ? 0 :
>                                 (1 + (!atkbd->softrepeat &&
> test_bit(atkbd->keycode[code], atkbd->dev->key)));

The above code is correct - in softrepeat mode, a value of '1' is
reported for each keystroke, even repeated ones, and that is then
filtered out by the input.c duplicate event filtering logic.

For hardrepeat mode, the value is changed to '2', and thus passes
through the sieve in input.c.

> Should we always recognize "repeats"? Then we woudl not need any
> workarounds, be it kbdrate or sysfs.

I'm not sure where this would help. The problem is that the DRAC3
'holds' the key pressed for full 500 ms before sending the release
scancde, even if the user pressed it just momentarily. It doesn't
generate repeat scancodes in this time. This however triggers the
softrepeat, which is by default set to 250 ms, causing repeated
characters all the time. 

-- 
Vojtech Pavlik
Director SuSE Labs
