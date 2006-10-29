Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965321AbWJ2RvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbWJ2RvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbWJ2RvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:51:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26518 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965316AbWJ2RvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:51:18 -0500
Date: Sun, 29 Oct 2006 18:50:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luming Yu <luming.yu@gmail.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, len.brown@intel.com,
       Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061029175005.GA3200@elf.ucw.cz>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <200610170145.03779.luming.yu@gmail.com> <20061025070713.GF5851@elf.ucw.cz> <200610280124.57212.luming.yu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610280124.57212.luming.yu@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Some whitespace is not okay there...
> > 									Pavel
> 
> updated version.

> index 27597c5..1a18cdb 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -190,7 +190,7 @@ static int fb_notifier_callback(struct n
>   * Creates and registers new backlight class_device. Returns either an
>   * ERR_PTR() or a pointer to the newly allocated device.
>   */
> -struct backlight_device *backlight_device_register(const char *name, void *devdata,
> +struct backlight_device *backlight_device_register(const char *name,struct device *dev,  void *devdata,
>  						   struct

80-columns, and fix the whitespace, please.

> --- /dev/null
> +++ b/drivers/video/output.c
> @@ -0,0 +1,110 @@
> +/*
> + * Video output switch support
> + */

I guess this one needs copyright/GPL.

> +	struct output_device *new_dev;
> +	int	ret_code = 0;

Indentation is wrong where... 

> +	new_dev = (struct output_device *) kzalloc( sizeof(struct
output_device), GFP_KERNEL);

Cast should not be needed.

> +	strlcpy(new_dev->class_dev.class_id, name, KOBJ_NAME_LEN);
> +	class_set_devdata(&new_dev->class_dev, devdata);
> +	ret_code = class_device_register(&new_dev->class_dev);
> +	if (ret_code){

") {", please.

> +		kfree (new_dev);

..and no space between kfree and its arguments.


> @@ -0,0 +1,27 @@
> +The output sysfs class driver is to provide video output abstract layer that can be used to hook platform specific methods to enable/disable video output device through common sysfs interface.
> +

80-columns, please. And some title would be nice.

> @@ -141,11 +144,11 @@ struct acpi_video_device_cap {
>  	u8 _ADR:1;		/*Return the unique ID */
>  	u8 _BCL:1;		/*Query list of brightness control levels supported */
>  	u8 _BCM:1;		/*Set the brightness level */
> +	u8 _BQC:1;		/*Get current brightness level */
>  	u8 _DDC:1;		/*Return the EDID for this device */
>  	u8 _DCS:1;		/*Return status of output device */
>  	u8 _DGS:1;		/*Query graphics state */
>  	u8 _DSS:1;		/*Device state set */

It is nicer to have space between /* and comment.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
