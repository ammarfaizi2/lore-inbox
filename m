Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSIWSIR>; Mon, 23 Sep 2002 14:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSIWSHI>; Mon, 23 Sep 2002 14:07:08 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:24448 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S261288AbSIWSGw>;
	Mon, 23 Sep 2002 14:06:52 -0400
Subject: Re: kernel BUG at /usr/src/linux-2.5.37/include/asm/spinlock.h:123!
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: Bob Miller <rem@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020923084115.A17934@build.pdx.osdl.net>
References: <1032679548.2042.5.camel@devil> 
	<20020923084115.A17934@build.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Sep 2002 21:11:53 +0300
Message-Id: <1032804713.6616.68.camel@devil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 18:41, Bob Miller wrote:
> Mika,

Hi Bob,

> I haven't looked at the code yet... but most of the time when you see this
> error it is because the kernel is compiled with CONFIG_DEBUG_SPINLOCK and
> the code is using a lock that hasn't be initilized correctly (i.e.:
> SPIN_LOCK_UNLOCKED().

Yup. I usually compile new kernels with spinlock debugging.

Looks like a number of the ioctls in oss/audio.c have locking problems.
At least the following ones look buggy:

SNDCTL_DSP_SETTRIGGER
SNDCTL_DSP_GETIPTR
SNDCTL_DSP_GETOPTR
SNDCTL_DSP_GETODELAY

Each of these tries to manipulate a spinlock through the uninitialized
dmap pointer. SNDCTL_DSP_SETTRIGGER actually operates on both dmap_in
and dmap_out. It should presumably acquire locks for both.

Looks like a copy/paste error, probably a result of a hasty conversion
cli()/sti()'s to spinlocks.

Regards,

	MikaL

> 
> -- 
> Bob Miller					Email: rem@osdl.org
> Open Source Development Lab			Phone: 503.626.2455 Ext. 17

