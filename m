Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263047AbSJGNdw>; Mon, 7 Oct 2002 09:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263048AbSJGNdw>; Mon, 7 Oct 2002 09:33:52 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:17024 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263047AbSJGNdv>;
	Mon, 7 Oct 2002 09:33:51 -0400
Date: Mon, 7 Oct 2002 15:39:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Skip Ford <skip.ford@verizon.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021007153924.A264@ucw.cz>
References: <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <20021001155428.GA19122@win.tue.nl> <20021001175537.A13220@ucw.cz> <20021001162955.GA19132@win.tue.nl> <20021007140603.A627@ucw.cz> <200210071323.g97DNa7w001744@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210071323.g97DNa7w001744@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Mon, Oct 07, 2002 at 09:23:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 09:23:26AM -0400, Skip Ford wrote:
> Vojtech Pavlik wrote:
> > On Tue, Oct 01, 2002 at 06:29:55PM +0200, Andries Brouwer wrote:
> > > 
> > > In kbd-1.06. It is from May 2001, and I have been planning kbd-1.07
> > > for a while but there were no urgent changes, just more fonts and
> > > keymaps and the like. When you are done it is a good occasion for
> > > kbd-1.07.
> > 
> > Ok, here is a patch that should make it work correctly on all existing
> > kernels.
> > 
> > You may want to check that loadkeys supports keycodes over 127 (and for
> > future, over 255), too. I updated only getkeycodes/setkeycodes.
> 
> loadkeys and the kernel itself both reject attempts to set keycodes with
> a value >= NR_KEYS (128).
> 
> In kbd-1.06/src/loadkeys.y::addkey()
> 
>         if (index < 0 || index >= NR_KEYS)
> 	        lkfatal0(_("addkey called with bad index %d"), index);
> 
> And inside linux/drivers/char/vt_ioctl.c::do_kdsk_ioctl()
> 
> 	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> 		return -EINVAL;	
> 
> I had to change each of those to KEY_MAX.  Both files use NR_KEYS in
> other places so I don't what the correct fix is.  I guess NR_KEYS is
> still correct for some keyboards?

Ok, I fixed it now in the kernel [#define NR_KEYS (KEY_MAX+1)].
I think the loadkeys source probably shouldn't check for the limit (as
that can change between kernels), and instead rely on the kernel
rejecting invalid values.

-- 
Vojtech Pavlik
SuSE Labs
