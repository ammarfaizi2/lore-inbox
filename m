Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbUKLMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUKLMJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 07:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKLMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 07:09:19 -0500
Received: from f69246.upc-f.chello.nl ([80.56.69.246]:62445 "HELO
	lilith.cathedrallabs.org") by vger.kernel.org with SMTP
	id S262513AbUKLMJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 07:09:14 -0500
Date: Fri, 12 Nov 2004 10:09:12 -0200
From: aris@cefetpr.br
To: Micah Dowty <micah@navi.cx>
Cc: aris@cathedrallabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Force feedback support for uinput
Message-ID: <20041112120852.GA25736@cefetpr.br>
References: <20041110163751.GA13361@navi.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110163751.GA13361@navi.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
Hi!

> This patch adds support to uinput for Linux's force feedback interface.
> With these changes, it's possible to write drivers for force feedback
> joysticks and similar devices in userspace. It also adds a way to set
> the physical path of devices created via uinput, and it has a couple
> trivial bugfixes.
nice!

> My solution is to have a special input event, outside the range
> defined by the input system, that uinput sends to the application
> to signal when a callback has been entered. A particular callback
> invocation is identified by a request ID stored in this event.
(snip)
> +/* This is the new event type, used only by uinput.
> + * 'code' is UI_FF_UPLOAD or UI_FF_ERASE, and 'value'
> + * is the unique request ID. This number was picked
> + * arbitrarily, above EV_MAX (since the input system
> + * never sees it) but in the range of a 16-bit int.
> + */
> +#define EV_UINPUT		0x0101
I guess it should be moved to input.h with other types of events.

> +/* To write a force-feedback-capable driver, the upload_effect
> + * and erase_effect callbacks in input_dev must be implemented.
> + * The uinput driver will generate a fake input event when one of
> + * these callbacks are invoked. The userspace code then uses
> + * ioctls to retrieve additional parameters and send the return code.
> + * The callback blocks until this return code is sent.
(snip)
what about moving this long comment to Documentation/input/uinput.txt?

the rest of the patch seems fine to me

thanks,

(p.s.: sorry for the delay and the dup that will follow. my server is
offline due adsl problems and the first answer is stuck there :)

--
Aristeu

