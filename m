Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVCVGKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVCVGKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVCVGGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:06:32 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:6798 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262326AbVCVGEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:04:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: All Linux <allinux@gmail.com>
Subject: Re: [PATCH] 2.6.12-rc1, ./drivers/base/platform.c
Date: Tue, 22 Mar 2005 01:04:33 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <cb57165a050321213210961749@mail.gmail.com>
In-Reply-To: <cb57165a050321213210961749@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220104.34123.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 00:32, All Linux wrote:
> The latest prepatch, 2.6.12-rc1, introduced the following change.
> 
> --- a/drivers/base/platform.c   2005-03-17 17:35:04 -08:00
> +++ b/drivers/base/platform.c   2005-03-17 17:35:04 -08:00
> @@ -131,7 +131,7 @@
>          pdev->dev.bus = &platform_bus_type;
>  
>          if (pdev->id != -1)
> -                snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u",
> pdev->name, pdev->id);
> +                snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%u",
> pdev->name, pdev->id);
>          else
>                  strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
> 
> It causes problem, as most platform files, for example,
> arch/ppc/platforms/katana.c, still use the old name without ".". I do
> not understand why bus_id "mpsc.0" is better than "mpsc0".
> Please explain what is the benefit of introducing such a change,
> before I can submit a patch for all those platform files to work with
> this change.
> Please CC me, as I am currently not in the list.
> 

Devices/drivers ending with a digit, such as i8250, produce "wierd"
names - i82500, i82501, etc.

-- 
Dmitry
