Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTIDBoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTIDBny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:43:54 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48907
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264466AbTIDBnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:43:09 -0400
Date: Wed, 3 Sep 2003 18:43:27 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mehmet Ceyran <mceyran@web.de>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: drivers/sound/i810_audio.c bug and patch
Message-ID: <20030904014327.GK16361@matchmail.com>
Mail-Followup-To: Mehmet Ceyran <mceyran@web.de>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <200309031429.01672.m.c.p@wolk-project.de> <005d01c37273$88183840$0100a8c0@server1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005d01c37273$88183840$0100a8c0@server1>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:31:40AM +0200, Mehmet Ceyran wrote:
> I found out that the driver gives the sound chip 10 chances to become
> ready and my sound chip fails to do that in time. The following patch
> gives the chip 100 tries instead of 10:
> 
> ---8<---
> --- i810_audio.c	2003-09-02 13:58:02.000000000 +0200
> +++ i810_audio.c.new	2003-09-02 13:58:12.000000000 +0200
> @@ -2727,7 +2727,7 @@
>  		      i810_ac97_get(codec, AC97_POWER_CONTROL) &
> ~0x7f00);
>  
>  	/* wait for analog ready */
> -	for (i=10; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) &
> 0xf) != 0xf); i--)
> +	for (i=100; i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) &
> 0xf) != 0xf); i--)
>  	{
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		schedule_timeout(HZ/20);
> --->8---
> 
> Well, why not? The loop will only go through it's body 100 times if the
> hardware is actually not available or corrupt and even in this case the
> whole block won't take much time. It works for me and it should work for
> all the other people using this driver too:

Why busy wait especially when you can sleep 1ms each time and poll less?
