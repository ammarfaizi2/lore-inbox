Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEGXPl>; Tue, 7 May 2002 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315448AbSEGXPk>; Tue, 7 May 2002 19:15:40 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:25342 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315445AbSEGXPi>; Tue, 7 May 2002 19:15:38 -0400
Date: Tue, 07 May 2002 17:12:21 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <285820000.1020816741@flay>
In-Reply-To: <3CD858AA.5050601@didntduck.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -	outb_p(14, vidport);
> -	outb_p(0xff & (pos >> 9), vidport+1);
> -	outb_p(15, vidport);
> -	outb_p(0xff & (pos >> 1), vidport+1);
> +	outb_local(14, vidport); slow_down_io();
> +	outb_local(0xff & (pos >> 9), vidport+1); slow_down_io();
> +	outb_local(15, vidport); slow_down_io();
> +	outb_local(0xff & (pos >> 1), vidport+1); slow_down_io();

You converted the outb_p's to plain outb's. I'm not sure of the reasoning
behind why they were there, but I wasn't brave enough to remove that ;-)
See the patch I mailed out earlier, basically the same idea, but I created
outb_local_p and friends.

Actually, I screwed it up slightly, and put outb_p_local in one, and outb_local_p
in the other. oops.

M.



