Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTIGFdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTIGFdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:33:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24083 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261409AbTIGFdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:33:13 -0400
Date: Sun, 7 Sep 2003 07:33:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, jsimmons@infradead.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
Message-ID: <20030907053309.GA963@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, jsimmons@infradead.org,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
References: <20030906201417.GI14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906201417.GI14436@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 10:14:18PM +0200, Adrian Bunk wrote:
> When doing a "make" inside an already compiled kernel source there 
> shouldn't be anything rebuilt. I've identified three places where this 
> isn't the case in recent 2.6 kernels:
> 
> 1. ikconfig
>   CC      kernel/configs.o
> even when the .config wasn't changed

configs.o included compile.h. Compile.h contains date when kernel was
compiled, and gets updated each time there is new .o files.
That is fixed in patch sent to Randy.

> 2. pnmtologo
> The following happens again once, but not when doing a third "make":
>   ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
>   CC      drivers/video/logo/logo_linux_mono.o
>   ./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
>   CC      drivers/video/logo/logo_linux_vga16.o
>   ./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
>   CC      drivers/video/logo/logo_linux_clut224.o
>   LD      drivers/video/logo/built-in.o
>   LD      drivers/video/built-in.o

I have sent a patch to James Simmons some time ago. I will try to dig it
up and  see if it still applies, and fixes the problem.


> 3. aic7xxx
>   drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r 
>   drivers/scsi/aic7xxx/aic79xx_reg.h \
>                       -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i 
>   aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
>                       drivers/scsi/aic7xxx/aic79xx.seq
>   drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
>   CC      drivers/scsi/aic7xxx/aic79xx_core.o

New to me, I will take a look.

	Sam
