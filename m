Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTIZKYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTIZKYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:24:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:12433 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262051AbTIZKYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:24:07 -0400
Date: Fri, 26 Sep 2003 12:24:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Keyboard oddness.
Message-ID: <20030926102403.GA8864@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064569422.21735.11.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 11:43:43AM +0200, Nicolas Mailhot wrote:
> Vojtech Pavlik  wrote:
> 
> |> Many people have reported missing key releases, and, as a consequence
> | of that,
> | > stuck keys. Your reports feel a bit different: the e0 is sometimes lost from
> | > a key press, sometimes from a key release.
> 
> | I'm wondering if it could be a bug in the i8042.c driver ...
> 
> This is worse than that. I'm seing the same kind of bug on a pure HID+EHCI setup 
> and I've seen other reports of USB problems on the lists these past months.

Well, the autorepeat-gone-bonkers is just a symptom, and a likely one,
not a cause. Few people will notice a missed keypress, just assume a bad
contact on the key, but a missing key release simply must cause infinite
autorepeat until another (or the same) key is pressed and released.

> I can't just believe everyone and his cat has suddenly a faulty/broken keyboard.
> 
> The fact is software autorepeat seems extremely brittle in 2.6 and goes nuts every
> once in a while for *everyone* (and I also seem to remember this was not always the 
> case - the first 2.5 I tried didn't go mad on my setup this only happened later in 
> 2.5.7x times I think). Now maybe the underlying keyboard drivers are feeding it junk
> I don't know but this is no justification for the way it's been misbehaving (crap 
> hardware happens, glitchy hardware is common but the autorepeat code seems to expect
> ideal behaviour that only happens on paper)
> 
> Couldn't it at least detect there's a problem ? Most people I know do not press a key
> 2000+ times in a row during normal activity.

You do. Scrolling up/down in a document is one example. And there is no
point to limit the repeat to say 80 or 200 characters. You would still
hate having 80 repeated characters and then it stopping.

The problem really is there is no way to detect it. My latest patches
should fix this for AT keyboards by not using software autorepeat for
them.

Of course this won't fix any problems with USB, if there are still any.
My USB keyboard works just perfectly, no problems with the autorepeat.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
