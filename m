Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWAONQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWAONQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 08:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWAONQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 08:16:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50706 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751927AbWAONQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 08:16:33 -0500
Date: Sun, 15 Jan 2006 13:16:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Thomas Fazekas <thomas.fazekas@gmail.com>, linux-kernel@vger.kernel.org,
       arch@archlinux.org
Subject: Re: Modify setterm color palette
Message-ID: <20060115131620.GA24976@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Thomas Fazekas <thomas.fazekas@gmail.com>,
	linux-kernel@vger.kernel.org, arch@archlinux.org
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com> <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:15:23PM +0100, Jan Engelhardt wrote:
> drivers/char/vt.c: default_red, default_grn, default_blu
> 
> You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
> digit (range 0-F), and RGB are the components. Check console_codes(4) and 
> go figure. :)

I for one prefer the standard VT100 yellow instead of brown, and I
have an escape sequence to do that similar to the one you show above.

However, there's one major flaw - programs recently (and by that I mean
FC2-like recently) have started to do complete console resets, which
result in the users settings being completely wiped out.

For instance, I have:

if [ "$TERM" = "linux" ]; then
  echo -ne '\e]P3aaaa00'
fi

in the bash login scripts.  Run mutt 1.4 and that gets wiped out.
Previous version of mutt (1.2?) didn't do this.

So, in essence, this is a completely useless solution.  I think we need
a separate escape sequence to modify the system default so that peoples
preferences do not get inadvertently wiped out by programs.

(I have also considered writing a module to locate the default palette
and "correct" it.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
