Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbSJGNWZ>; Mon, 7 Oct 2002 09:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbSJGNWZ>; Mon, 7 Oct 2002 09:22:25 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:33983 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S263028AbSJGNWM>; Mon, 7 Oct 2002 09:22:12 -0400
Message-Id: <200210071323.g97DNa7w001744@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 7 Oct 2002 09:23:26 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <20021001155428.GA19122@win.tue.nl> <20021001175537.A13220@ucw.cz> <20021001162955.GA19132@win.tue.nl> <20021007140603.A627@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021007140603.A627@ucw.cz>; from vojtech@suse.cz on Mon, Oct 07, 2002 at 02:06:03PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Mon, 7 Oct 2002 08:27:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 01, 2002 at 06:29:55PM +0200, Andries Brouwer wrote:
> > 
> > In kbd-1.06. It is from May 2001, and I have been planning kbd-1.07
> > for a while but there were no urgent changes, just more fonts and
> > keymaps and the like. When you are done it is a good occasion for
> > kbd-1.07.
> 
> Ok, here is a patch that should make it work correctly on all existing
> kernels.
> 
> You may want to check that loadkeys supports keycodes over 127 (and for
> future, over 255), too. I updated only getkeycodes/setkeycodes.

loadkeys and the kernel itself both reject attempts to set keycodes with
a value >= NR_KEYS (128).

In kbd-1.06/src/loadkeys.y::addkey()

        if (index < 0 || index >= NR_KEYS)
	        lkfatal0(_("addkey called with bad index %d"), index);

And inside linux/drivers/char/vt_ioctl.c::do_kdsk_ioctl()

	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
		return -EINVAL;	

I had to change each of those to KEY_MAX.  Both files use NR_KEYS in
other places so I don't what the correct fix is.  I guess NR_KEYS is
still correct for some keyboards?

-- 
Skip
