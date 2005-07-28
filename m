Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVG1WRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVG1WRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVG1WRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:17:02 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:11738 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261587AbVG1WQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p9hqcPM4DEjDSUXHytQ4wcYhSJxq9cOMBTABQwtmjzGnc64VYORpOfOfPrMNXyWWJ85MQVskNcKy/GKXQ+/tn4dsMNBICO5/4NbPe7Xaj/3ELYAtNRFIrTAYtvhBbbivZGfbBmFk89u9hxo9aUMfgs2tiRIHf/WMsw45tyNs1XE=
Message-ID: <42E95950.2080101@gmail.com>
Date: Fri, 29 Jul 2005 06:16:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
References: <200507280031.j6S0V3L3016861@hera.kernel.org>	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> <9e473391050728074573e40038@mail.gmail.com>
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Can you review this fix for the issues below? I fixed things to
> automatically adjust the number of entries to whatever fits in
> PAGE_SIZE.
>
> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> --- a/drivers/video/fbsysfs.c
> +++ b/drivers/video/fbsysfs.c
> @@ -244,15 +244,15 @@ static ssize_t show_virtual(struct class
>  
>  /* Format for cmap is "%02x%c%4x%4x%4x\n" */
>   
Why is the alpha channel not given the same weight as the RGB? Wouldn't
it be correct to also give it 4 bytes (16 bits)  Also, what would happen if
you exceed 256 entries, you've only alloted a maximum of 256 for the
index?  This will also be a problem because you cannot access cmap entries
past 255.

So, 4 bytes per channel + 4 bytes for the index will be needed per entry,

Tony

