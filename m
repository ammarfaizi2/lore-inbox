Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSHZQ3P>; Mon, 26 Aug 2002 12:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSHZQ3P>; Mon, 26 Aug 2002 12:29:15 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:52946 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317931AbSHZQ3N>;
	Mon, 26 Aug 2002 12:29:13 -0400
Date: Mon, 26 Aug 2002 18:33:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com, ralf@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce CONFIG_INPUT as forward symbol (with diff)
Message-ID: <20020826183316.B17078@ucw.cz>
References: <20020826093428.B2524@ucw.cz> <Pine.LNX.4.33L2.0208260923510.25879-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0208260923510.25879-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Mon, Aug 26, 2002 at 09:28:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 09:28:08AM -0700, Randy.Dunlap wrote:
> [repost with patch this time]
> 
> Hi,
> 
> I've been using gcml2 from Greg Banks to look at CONFIG_
> variable dependencies in config.in files.
> 
> By moving drivers/input/config.in before drivers/char/Config.in
> and drivers/usb/Config.in for arch/alpha and arch/mips(64),
> several (7) instances of this message:
>   forward declared symbol "CONFIG_INPUT" used in dependency list
> and (6) instances of this one:
>   forward declared symbol "CONFIG_SOUND_GAMEPORT" used in
>   dependency list
> can be removed.  (Yes, the latter one is for OSS drivers,
> so it's not so important.)
> 
> It also adds one forward dependency for a USB joystick
> in the input subsystem [still only for alpha and mips(64)].
> Most other arches are already like this.
> 
> This patch is to 2.5.31-bk7 (jgarzik's latest snapshot).
> Please apply.
> 
> On Mon, 26 Aug 2002, Vojtech Pavlik wrote:
> |
> | I'd like to take a look at the patch - both the symbols are from the
> | input drivers. Where can I find it? And what was the exact problem?
> 
> Yes, I forgot the patch...too late last night.
> It's now below.
> 
> This patch just makes alpha and mips(64) use the same ordering
> for "source drivers/input/Config.in" that most other arches use,
> so that there are fewer forward references to CONFIG_INPUT.
> 
> Please apply.

I see. Yes, this is correct.

> --- ./arch/alpha/config.in.inputt	Sun Aug 25 21:14:09 2002
> +++ ./arch/alpha/config.in	Sun Aug 25 21:37:33 2002
> @@ -335,6 +335,7 @@
>  fi
>  endmenu
> 
> +source drivers/input/Config.in
>  source drivers/char/Config.in
>  source drivers/char/Config-tape.in
> 
> @@ -371,7 +372,6 @@
>  endmenu
> 
>  source drivers/usb/Config.in
> -source drivers/input/Config.in
> 
>  source net/bluetooth/Config.in
> 
> --- ./arch/mips64/config.in.inputt	Sun Aug 25 21:14:09 2002
> +++ ./arch/mips64/config.in	Sun Aug 25 22:08:45 2002
> @@ -186,6 +186,8 @@
>  fi
>  endmenu
> 
> +source drivers/input/Config.in
> +
>  source drivers/char/Config.in
> 
>  source drivers/char/Config-tape.in
> @@ -229,7 +231,6 @@
>  fi
> 
>  source drivers/usb/Config.in
> -source drivers/input/Config.in
> 
>  mainmenu_option next_comment
>  comment 'Kernel hacking'
> --- ./arch/mips/config.in.inputt	Sun Aug 25 21:14:09 2002
> +++ ./arch/mips/config.in	Sun Aug 25 22:04:30 2002
> @@ -395,6 +395,8 @@
>  fi
>  endmenu
> 
> +source drivers/input/Config.in
> +
>  source drivers/char/Config.in
> 
>  source drivers/char/Config-tape.in
> @@ -482,7 +484,6 @@
>  fi
> 
>  source drivers/usb/Config.in
> -source drivers/input/Config.in
> 
>  mainmenu_option next_comment
>  comment 'Kernel hacking'

-- 
Vojtech Pavlik
SuSE Labs
