Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161534AbWJKVwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161534AbWJKVwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161535AbWJKVwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:52:10 -0400
Received: from kurby.webscope.com ([204.141.84.54]:48294 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1161534AbWJKVwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:52:05 -0400
Message-ID: <452D6703.7070900@linuxtv.org>
Date: Wed, 11 Oct 2006 17:49:55 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jonathan Corbet <corbet@lwn.net>
CC: Greg KH <gregkh@suse.de>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mchehab@infradead.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Sascha Hauer <s.hauer@pengutronix.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [patch 48/67] Fix VIDIOC_ENUMSTD bug
References: <10090.1160603175@lwn.net>
In-Reply-To: <10090.1160603175@lwn.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet wrote:
>> So any application which passes in index=0 gets EINVAL right off the bat
>> - and, in fact, this is what happens to mplayer.  So I think the
>> following patch is called for, and maybe even appropriate for a 2.6.18.x
>> stable release.
> 
> The fix is worth having, though I guess I'm no longer 100% sure it's
> necessary for -stable, since I don't think anything in-tree other than
> vivi uses this interface in 2.6.18.  If you are going to include it,
> though, it makes sense to put in Sascha's fix too - both are needed to
> make the new v4l2 ioctl() interface operate as advertised.
> 
> jon
> 
> 
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Subject: [PATCH] copy-paste bug in videodev.c
> Date: Mon, 11 Sep 2006 10:50:55 +0200
> To: video4linux-list@redhat.com
> 
> This patch fixes a copy-paste bug in videodev.c where the vidioc_qbuf()
> function gets called for the dqbuf ioctl.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> diff --git a/drivers/media/video/videodev.c
> b/drivers/media/video/videodev.c
> index 88bf2af..8abee33 100644
> --- a/drivers/media/video/videodev.c
> +++ b/drivers/media/video/videodev.c
> @@ -739,13 +739,13 @@ static int __video_do_ioctl(struct inode
>  	case VIDIOC_DQBUF:
>  	{
>  		struct v4l2_buffer *p=arg;
> -		if (!vfd->vidioc_qbuf)
> +		if (!vfd->vidioc_dqbuf)
>  			break;
>  		ret = check_fmt (vfd, p->type);
>  		if (ret)
>  			break;
>  
> -		ret=vfd->vidioc_qbuf(file, fh, p);
> +		ret=vfd->vidioc_dqbuf(file, fh, p);
>  		if (!ret)
>  			dbgbuf(cmd,vfd,p);
>  		break;
> 
> 

This is fine with me...  I have added cc to Mauro, he might want to add
his sign-off as well.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

