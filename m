Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSEZLnU>; Sun, 26 May 2002 07:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSEZLnT>; Sun, 26 May 2002 07:43:19 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:63104 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315971AbSEZLnT>;
	Sun, 26 May 2002 07:43:19 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15600.51720.488266.491713@argo.ozlabs.ibm.com>
Date: Sun, 26 May 2002 21:42:00 +1000 (EST)
To: Russell King <rmk@arm.linux.org.uk>
Cc: A Guy Called Tyketto <tyketto@wizard.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.18-dj1
In-Reply-To: <20020526090046.A32058@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> This oops has existed over several 2.5 versions.  The following was thrown
> around to fix it (I don't remember who though).
> 
> --- orig/drivers/video/fbcmap.c	Fri May  3 11:12:44 2002
> +++ linux/drivers/video/fbcmap.c	Fri May 10 19:39:38 2002
> @@ -150,9 +150,9 @@
>      else
>  	tooff = from->start-to->start;
>      size = to->len-tooff;
> -    if (size > from->len-fromoff)
> +    if (size > (int)(from->len-fromoff))
>  	size = from->len-fromoff;
> -    if (size < 0)
> +    if (size <= 0)
>  	return;
>      size *= sizeof(u16);

That looks like my patch.  It stops the oops (by fixing a signed
vs. unsigned comparison bug) but doesn't fix the colormap handling.
On my G4 powerbook, which has an ATI Rage 128 (Mobility M3 AGP 2x) the
screen colours are all totally wrong under X when I boot 2.5.18.  I
have Option "UseFBDev" in my /etc/X11/XF86Config-4, so the X server is
using the kernel frame buffer driver to do colormap updates.  (The
colours are all OK on the text consoles though.)

Paul.
