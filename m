Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVGDWF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVGDWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 18:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVGDWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 18:05:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42887 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261693AbVGDWFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 18:05:19 -0400
Date: Tue, 5 Jul 2005 00:05:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: federico <xaero@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setkeycodes, sysrq, and USB keyboard
Message-ID: <20050704220532.GA2086@ucw.cz>
References: <42C9AD67.5050808@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C9AD67.5050808@inwind.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 11:43:03PM +0200, federico wrote:
> hi all,
> 
> i have a problem: i got a white Apple usb keyboard, but this keyboard
> doesn't have PrintScr nor SysRq.
> i read in Documentation/sysrq.txt how to change the SYSRQ scancode.
> i launched showkey and acknowledged that R_Alt+F13 is 100,183 => 64b7.
> i ran
> 
>  # setkeycodes 64b7 84
> KDSETKEYCODE: No such device
> failed to set scancode b7 to keycode 84
> 
> i'm on a gentoo-vanilla 2.6.13_rc1 with kbd-1.12-r5. (or on
> 2.6.11-gentoo-r9 which produces the same result)
> 
> here's some relevant output from strace:
> 
> open("/dev/tty", O_RDWR) = 3
> ioctl(3, KDGKBTYPE, 0xbffdfcb7) = 0
> ioctl(3, KDSETKEYCODE, 0xbffdfd20) = -1 ENODEV (No such device)
> dup(2) = 4
> fcntl64(4, F_GETFL) = 0x8001 (flags O_WRONLY|O_LARGEFILE)
> close(4) = 0
> ...
> write(2, "KDSETKEYCODE: No such device\n", 29KDSETKEYCODE: No such device
> ) = 29
> ...
> write(2, "failed to set scancode 64b7 to k"..., 42failed to set scancode
> 64b7 to
> keycode 84
> ) = 42
> 
> if anyone has a possible solution i really appreciate.
> ciao!
 
Sorry, you can't use 'setkeycodes' on USB keyboards. They don't use the
PS/2 protocol, and hence it doesn't make sense.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
