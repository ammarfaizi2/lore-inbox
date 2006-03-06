Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752386AbWCFLFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbWCFLFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbWCFLFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:05:44 -0500
Received: from mail1.kontent.de ([81.88.34.36]:4811 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1752384AbWCFLFn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:05:43 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Date: Mon, 6 Mar 2006 12:05:32 +0100
User-Agent: KMail/1.8
Cc: "Lanslott Gish" <lanslott.gish@gmail.com>, linux-kernel@vger.kernel.org,
       "Greg KH" <greg@kroah.com>, "Alan Cox" <alan@redhat.com>
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
In-Reply-To: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603061205.32660.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. März 2006 10:14 schrieb Lanslott Gish:
> hi,
> 
> this is the first version of the patch from a newbie :)
> add support for PANJIT TouchSet USB touchscreen device.
> 

> +#define TOUCHSET_DOWN			0x01
> +#define TOUCHSET_POINT_TOUCH		0x81
> +#define TOUCHSET_POINT_NOTOUCH		0x80
> +
> +#define TOUCHSET_GET_TOUCHED(dat)	((((dat)[0]) & TOUCHSET_DOWN) ? 1 : 0)

Drop the "?"

> +static int touchset_open(struct input_dev *input)
> +{
> +	struct touchset_usb *touchset = input->private;
> +
> +	touchset->irq->dev = touchset->udev;
> +
> +	if (usb_submit_urb(touchset->irq, GFP_ATOMIC))

GFP_KERNEL

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void touchset_close(struct input_dev *input)
> +{
> +	struct touchset_usb *touchset = input->private;
> +
> +	usb_kill_urb(touchset->irq);
> +}
> +
> +static int touchset_alloc_buffers(struct usb_device *udev,
> +				  struct touchset_usb *touchset)
> +{
> +	touchset->data = usb_buffer_alloc(udev, TOUCHSET_REPORT_DATA_SIZE,
> +	                                  SLAB_ATOMIC, &touchset->data_dma);

SLAB_KERNEL

	Regards
		Oliver
