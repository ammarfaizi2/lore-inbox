Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWBLIvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWBLIvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWBLIvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:51:36 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:55923 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbWBLIvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:51:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FI8PK3BorDypYvavPdizOrnZtyVssrO0edRjHJa+5J0ZRW65MHQfnqEqYEVat12n5bFJA1dRncTgKxMz4ijVhicnErxoWmry7+/0pWP0Qd3H65u8/OFlJiL4NVTyISwvRilgCUg/z4Pw77MIpOD9waqyII4BLtDPKmBJJKe4sis=
Message-ID: <43EEF711.2010409@gmail.com>
Date: Sun, 12 Feb 2006 10:51:29 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Jan Merka <merka@highsphere.net>, Pavel Machek <pavel@ucw.cz>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel]
 Re: [ 00/10] [Suspend2] Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain>	<200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz>	<200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com>
In-Reply-To: <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Feb 11, 2006, at 11:36, Jan Merka wrote:

>> I strongly disagree. I got suspend-to-RAM to work but its utility is
>> seriously limited by battery capacity. For example, on my laptop (Sony
>> VGN-B100B) with 1.5GB of RAM, a fully charged battery is drained in
>> about 18 hours if the laptop was suspended to RAM.
> 
> Ick, that's kind of sucky hardware then.  My PowerBook with 1GB RAM
> easily gets a week of sleep time off a fully charged battery; I don't
> think I've rebooted it _once_ in the last 2 months, I just leave it
> sleeping in my bag the whole time.  Sony must be doing something wrong,
> because there's easily enough power in a single battery to keep RAM
> refreshed for a _long_ time.
> 
>> Yes, for a few hours suspend-to-RAM is convenient but suspend-to-disk
>> is _reliable_ and _safe_.
> 
> As to the safety issue, I have my Apple Powerbook configured to suspend
> to RAM, and if it gets critically low on battery I have the firmware set
> to resume it automatically and my scripts shut it down so I don't lose
> data.  Suspend-to-RAM when implemented properly _is_ reliable and safe,
> but it seems like a lot of hardware manufacturers get it wrong.
> 

Hello,

I don't understand how a fundamental (good) debate of how
suspend to disk should be implemented in kernel, changed
into this one.

I don't care what Linus said... Suspend-to-disk is more
complicated than suspend-to-RAM. It is more complicated
since it provides more features. Suspend-to-RAM only stores
state, where Suspend-to-disk need to store the state
somewhere thus changing the initial state.

There is a long list of features available at
http://wiki.suspend2.net/FeatureUserRegister, which cannot
be provided using suspend-to-RAM, examples:
1. Store state on files - this allow you to resume your
machine into a different OS.
2. Encrypt state - this allow you to be sure that your data
is stored encrypted. (Yes... You can encrypt the memory...
but then you need a whole initramfs clone in order to allow
the user to specify how he want to encrypt/decrypt).
3. Network resume - this allow you to resume a network
machine (Not implemented yet, but cannot be done if
suspend-to-RAM is the sole implementation).
4. Support desktops/servers - this allow you to
suspend/resume hardware that is not designed to sleep, in
order to minimize downtime on power failure.

And another fact: Suspend-to-RAM implementation can be
derived form suspend-to-disk but not the other way around.

So let's invert the initial "fact"...
Suspend-to-RAM is basically for people that don't need the
full functionality of suspend-to-disk, after I got
suspend-to-disk to work reliably here (suspend2), I *NEVER*
use suspend-to-RAM.

Best Regards,
Alon Bar-Lev.
