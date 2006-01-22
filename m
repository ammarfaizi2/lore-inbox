Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWAVTiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWAVTiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAVTiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:38:19 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:30899 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751166AbWAVTiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:38:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pKvk566tUGIkJvZVPgJuXg4CYyWGKiPiPL3AQ3g6ILCMtJoYO3dNsxmPC0ds8cNzmv+lPNvxMHEVFxu0+egeG9FQOqG4bmri6bt2VS2xUDd3MXCo+lWx5kQHxbPPcNAx880PANa9B3msltn4jniFCOoBfHIPTniW5or87/tQahs=
Date: Sun, 22 Jan 2006 22:55:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marek Va?ut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Guillemot joystick not working since 2.6.14
Message-ID: <20060122195550.GA19983@mipter.zuzino.mipt.ru>
References: <200601221250.26792.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601221250.26792.marek.vasut@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:50:26PM +0100, Marek Va?ut wrote:
> I found a problem with guillemot "force feedback joystick". It?s not working
> since 2.6.13.2-mm3. 2.6.14.2 wasn?t working too. 2.6.15-mm2 is the same. When
> I plug it in, it prints "configuration #1 chosen from 1 choice" "registered
> new driver iforce" and >"iforce: probe of 4-2:1.0 failed with error -12"<
> It was working well on 2.6.13.1, but now it doesnt. I am not able to debug the 
> kernel. Could you please fix this or tell me what am I doing wrong? Thanks.

Please try this patch

--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
 	int i;
 
 	input_dev = input_allocate_device();
-	if (input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&iforce->wait);

