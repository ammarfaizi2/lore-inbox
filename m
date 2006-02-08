Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbWBHIvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbWBHIvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWBHIvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:51:32 -0500
Received: from styx.suse.cz ([82.119.242.94]:63892 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030581AbWBHIvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:51:31 -0500
Date: Wed, 8 Feb 2006 09:51:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shaun Jackman <sjackman@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Elo touch panel
Message-ID: <20060208085124.GA4078@suse.cz>
References: <7f45d9390602061830k6b984ban6fb302a3089cac6c@mail.gmail.com> <20060207081415.GA6731@suse.cz> <7f45d9390602071541n65693ae5m7428d59dedcd5ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390602071541n65693ae5m7428d59dedcd5ae5@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 04:41:16PM -0700, Shaun Jackman wrote:

> There's a bug in inputattach. The SERIO_RS232 constant is completely
> mucking the bits that specify the protocol.
> 
> --- inputattach.c-      2006-02-07 14:37:04.000000000 -0700
> +++ inputattach.c       2006-02-07 16:22:07.000000000 -0700
> @@ -455,7 +455,7 @@
>                 return 1;
>         }
> 
> -       devt = SERIO_RS232 | input_types[type].type | (id << 8) | (extra << 16);
> +       devt = input_types[type].type | (id << 8) | (extra << 16);
> 
>         if(ioctl(fd, SPIOCSTYPE, &devt)) {
>                 fprintf(stderr, "inputattach: can't set device type\n");
> 
> Cheers,
> Shaun
> 
> APPENDIX A
> 
> You probably know this better than I do, but the .type above is
> misnamed. It should really be .proto. It's impossible, as far as I can
> tell, to specify the type (like SERIO_RS232) with a SPIOCSTYPE call.
 
It's an incompatibility in a later rework of serio.h/serport.c.
SERIO_RS232 used to be 0x02000000, now the constant isn't shifted up
anymore, which messed up things. Also, the type used to be possible to
set, but I don't think that needs to be fixed, since there are so far no
ttys that'd need a different serio type. 

I'll apply your fix to inpuatttach. Thanks for spotting the bug.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
