Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWADJqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWADJqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWADJqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:46:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030198AbWADJqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:46:34 -0500
Date: Wed, 4 Jan 2006 01:45:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jiri Slaby" <xslaby@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, atlka@pg.gda.pl, greg@kroah.com
Subject: Re: [PATCH 1/4] media-radio: Pci probing for maestro radio
Message-Id: <20060104014532.3909a51e.akpm@osdl.org>
In-Reply-To: <20051231161634.422661E32EE@anxur.fi.muni.cz>
References: <200500919343.923456789ble@anxur.fi.muni.cz>
	<20051231161634.422661E32EE@anxur.fi.muni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jiri Slaby" <xslaby@fi.muni.cz> wrote:
>
> +	retval = video_register_device(maestro_radio_inst, VFL_TYPE_RADIO,
>  +		radio_nr);
>  +	if (retval) {
>  +		printk(KERN_ERR "can't register video device!\n");
>  +		goto errfr1;
>  +	}
>  +
>  +	if (!radio_power_on(radio_unit)) {
>  +		retval = -EIO;

Shouldn't we unregister the video device here?

>  +		goto errfr1;
>  +	}
>  +
>  +	dev_info(&pdev->dev, "version " DRIVER_VERSION " time " __TIME__ "  "
>  +		__DATE__ "\n");
>  +	dev_info(&pdev->dev, "radio chip initialized\n");
>  +
>  +	return 0;
>  +errfr1:
>  +	kfree(maestro_radio_inst);
>  +errfr:
>  +	kfree(radio_unit);
>  +err:
>  +	return retval;
>  +
