Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWFTCQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWFTCQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWFTCQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:16:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:56423 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964892AbWFTCQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:16:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqK5sbRGnFIYgishMXmdWLQTTpyjvO3wTa4CV8DsnB082+UArMbc6f9bp4Ryfl46xNxAlbBmlOXtO8TZ1AtX5xIE196/+TVoD4yXF2d+1slLINuIBh/T3YoY5N9Voy8CEEFKqv5XlseIMU8EHoVtp6rFqEMAW5mLk+Sm8p8RivI=
Message-ID: <9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
Date: Mon, 19 Jun 2006 22:16:33 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a Kconfig option
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <44974AC7.4060708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44957026.2020405@gmail.com>
	 <9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	 <44974AC7.4060708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > I gave this patch a try and it seems to work. I say seems because I
> > could not get the nvidiafb driver to set a usable mode after it was
> > bound/unbound.
>
> What do you mean by this?  You mean that you cannot restore vgacon?
> If that's the case, then yes, that is perfectly understandable as
> nvidiafb does not restore VGA to text mode.

modprobe fbcon
modprobe nvidiafb

Display is messed up.

I used to fix this by switching to X and back but the nvidia X driver
won't build on the mm kernel. I can try again and write a script to
echo a mode into sysfs after the modprobe.

When fbcon first gets a new fbdev driver registered with it, should it
pick one of the modes is supports and set it automatically?

>  or would it be better for each driver to set in a
> > default mode that it understands when it gets control? The fbdev
> > driver should not set a mode when it loads, but that doesn't mean
> > fbcon can't set one when it is activated. Similarly VGAcon would set
> > the mode (and load its fonts) when it regains control.
>
> The problem with vgacon setting its own mode is that it does not know
> anything about the hardware. So VGA text mode will need to rely on
> a secondary program to set the mode (whether it's vbetool, another
> fb driver, or X does not matter).

How does vbetool save state? Could VGAcon do whatever vbetool is doing?

-- 
Jon Smirl
jonsmirl@gmail.com
