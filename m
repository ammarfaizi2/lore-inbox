Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUI1CpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUI1CpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUI1CpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:45:11 -0400
Received: from sa2.bezeqint.net ([192.115.104.16]:21202 "EHLO sa2.bezeqint.net")
	by vger.kernel.org with ESMTP id S267511AbUI1CpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:45:01 -0400
Date: Tue, 28 Sep 2004 05:46:22 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4 + alps locks input in X (alps not identifying correctly)
Message-ID: <20040928034622.GA3158@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040927192744.GA8947@luna.mooo.com> <200409271604.33993.joakley@solutioninc.com> <m3wtyf792x.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wtyf792x.fsf@telia.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:25:42PM +0200, Peter Osterlund wrote:
> James Oakley <joakley@solutioninc.com> writes:
> 
> > On Monday 27 September 2004 4:27 pm, Micha Feigin wrote:
> > > I tried both with mm4 with the already included alps patch and with
> > > bk11 and bk13 with the patch manually applied. In both cases when
> > > starting X with the alps driver input is completely dead in X, both
> > > mouse and keyboard, including sysrq keys and num-lock/caps-lock.
> > 
> > I had this problem when I accidentally used the event device for my keyboard 
> > instead of the touchpad. It didn't help that every alps XF86Config example 
> > out there points to event1, which is my keyboard.
> > 

Thanks that solved the problem, no more lockups.

> > cat /proc/bus/input/devices to see which event device to use.
> 
> Or better yet, use the auto-dev feature, which should work if you have
> a new enough X driver and kernel patch.
> 

auto-dev doesn't work for me and I don't have time to check it
out. While poking around I did find another problem though.

There is also a kernel problem, to summarize, the touchpad is
identifying itself differently then with previous kernels and thus
isn't recognized at all by the kernel.

I don't know how much effect it actually has since some initialization
is also done through X.

The main problem I found:

Under 2.6.9-rc2-mm4 in alps.c under function alps_get_model, for the
call to ps2_command with PSMOUSE_CMD_GETINFO (the E6 report output) the
output is 00 00 14 instead of 00 00 64 like it was before and what is
expected, so the touchpad isn't recognized at all as an alps. (I can't
figure out whats causing the difference or how the return value is
received at all, and I don't have any more time to dig further into it).

Second problem is that hardware tapping is disabled by default
(I found no way to enable it externally) which in my case causes most
taps to be interpreted as double clicks instead of single clicks.

After fixing both things and X to use the right device things finally
work again.

> -- 
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
