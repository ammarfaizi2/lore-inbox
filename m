Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289698AbSAWFZ1>; Wed, 23 Jan 2002 00:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSAWFZR>; Wed, 23 Jan 2002 00:25:17 -0500
Received: from rj.SGI.COM ([204.94.215.100]:60323 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289679AbSAWFZC>;
	Wed, 23 Jan 2002 00:25:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jan Pospisil <honik@civ.zcu.cz>
Cc: linux-kernel@vger.kernel.org, bug-binutils@gnu.org
Subject: Re: undefined references when compiling kernel with binutils-2.11.92.0.12.3 
In-Reply-To: Your message of "Tue, 22 Jan 2002 14:43:16 BST."
             <Pine.LNX.4.33.0201221421050.20914-100000@aither.zcu.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Jan 2002 16:24:52 +1100
Message-ID: <25992.1011763492@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002 14:43:16 +0100 (CET), 
Jan Pospisil <honik@civ.zcu.cz> wrote:
>Hello, it has been posted so many times, and according to Richard Gooch it
>should be fixed in 2.4.18-pre3, however I am still having the problem
>undefined reference to `local symbols in discarded section .text.exit'
>particullary with the CONFIG_VIDEO_BT848=y (as a module it works fine).
>In function `bttv_probe':
>drivers/media/media.o(.text.init+0x1745): undefined reference to `local
>symbols in discarded section .text.exit'

That is a real coding bug that the new binutils has found and
highlighted.  bttv_probe() calls bttv_remove() which is defined as
__devexit, bttv_remove() is not there when the code is built in.  Take
it up with the bttv maintainer, it is a coding error, not binutils.

