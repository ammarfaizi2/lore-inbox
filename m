Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946007AbWBOQbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946007AbWBOQbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWBOQbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:31:03 -0500
Received: from solarneutrino.net ([66.199.224.43]:18441 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1946007AbWBOQbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:31:01 -0500
Date: Wed, 15 Feb 2006 11:30:58 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>,
       Nick Warne <nick@linicks.net>
Subject: Re: Random reboots
Message-ID: <20060215163058.GC17864@tau.solarneutrino.net>
References: <20060215160036.GB17864@tau.solarneutrino.net> <ARSSpsNs.1140020437.1823510.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ARSSpsNs.1140020437.1823510.khali@localhost>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 05:20:37PM +0100, Jean Delvare wrote:
> There's one chip missing. If memory serves, this board has two hardware
> monitoring chips: one Winbond Super-I/O and one LM85-compatible SMBus
> chip. You are missing the i2c-amd756 driver in your kernel build
> (CONFIG_I2C_AMD756) which prevents you from accessing that second chip.
> 
> Additionally, the Winbond Super-I/O chips are better supported by the
> newer w83627hf driver than by the w83781d you are using.
> 
> So, you should change your kernel configuration to:
> 
> CONFIG_I2C_AMD756=y
> #CONFIG_SENSORS_W83781D is not set
> CONFIG_SENSORS_W83627HF=y
> 
> Then you'll probably have much better results - even if the
> configuration file might need additional tweaking.

Aha, thanks.  I probably configured out the AMD756 when we switched to
this board from an actual AMD 7xx board, thinking it was no longer
appropriate.  I'll make the change this weekend.

> > Still, I don't see why the new kernel shouldn't be stable if 2.6.11.3
> > was.
> 
> If not software regression, the aging of your hardware might have caused
> it, as I mentioned earlier. But you are free to believe in the
> hypothesis you prefer, given that we are not currently able to
> demonstrate it anyway ;)

It could certainly be hardware, but it seems awfully unlikely that that
would occur exactly when I upgraded the kernel.  A kernel bug just seems
the most parsimonious explanation, to me.

-ryan
