Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTBNUo7>; Fri, 14 Feb 2003 15:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBNUo7>; Fri, 14 Feb 2003 15:44:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267399AbTBNUo6>; Fri, 14 Feb 2003 15:44:58 -0500
Date: Fri, 14 Feb 2003 20:54:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 - drivers/char/esp.c vs include/linux/serialP.h
Message-ID: <20030214205449.J14659@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200302142039.h1EKdYwZ029474@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302142039.h1EKdYwZ029474@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Feb 14, 2003 at 03:39:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 03:39:34PM -0500, Valdis.Kletnieks@vt.edu wrote:
> compiling drivers/char/esp.c with -Wundef triggers a warning:
> 
> In file included from drivers/char/esp.c:51:
> include/linux/serialP.h:27:6: warning: "LINUX_VERSION_CODE" is not defined
> 
> The code that trips it up:
> 
> #if (LINUX_VERSION_CODE < 0x020300)
> /* Unfortunate, but Linux 2.2 needs async_icount defined here and
>  * it got moved in 2.3 */
> #include <linux/serial.h>
> #endif
> 
> It's unclear if this should be fixed by adding a #include <linux/version.h>
> to esp.c, or if this code should summarily be lopped out of serialP.h.

My personal feeling woudl be to lop it out, and fix up anywhere
and everywhere which complains appropraitely.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

