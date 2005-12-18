Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVLRP40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVLRP40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVLRP40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:56:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27373 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965191AbVLRP4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:56:25 -0500
Date: Sun, 18 Dec 2005 15:56:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org,
       linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: [PATCH 1/5] - Fix 64-bit compile warnings
Message-ID: <20051218155622.GG27946@ftp.linux.org.uk>
References: <1134920704.6702.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134920704.6702.26.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 01:23:45PM -0200, Mauro Carvalho Chehab wrote:
> Fix 64-bit compile warnings
> diff --git a/drivers/media/common/saa7146_hlp.c b/drivers/media/common/saa7146_hlp.c
> index ec52dff..be34ec4 100644
> --- a/drivers/media/common/saa7146_hlp.c
> +++ b/drivers/media/common/saa7146_hlp.c
> @@ -562,7 +562,7 @@ static void saa7146_set_position(struct 
>  
>  	int b_depth = vv->ov_fmt->depth;
>  	int b_bpl = vv->ov_fb.fmt.bytesperline;
> -	u32 base = (u32)vv->ov_fb.base;
> +	u32 base = (u32)(unsigned long)vv->ov_fb.base;

That's not "fix", that's "confuse gcc so it doesn't notice the problem
anymore"...
