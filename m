Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWA1F7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWA1F7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 00:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWA1F7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 00:59:15 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:19908 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbWA1F7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 00:59:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EhzMmIe0I+diiyuldnbrK3IETbW/HuhnVSyeT7zCvJC4l5N13BNOvpXLD+mfpwthVsyzNvdoTVqmhtb37v8hb2ivbMKQZiYAlbFp0+vz0TEhOY/JtORNO0DMPBFMwfsSjlo6OgsovrksXUnUTOKTIBEtRqT8jf6WMDmpq4WjAnQ=
Message-ID: <43DB0839.6010703@gmail.com>
Date: Sat, 28 Jan 2006 13:59:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: benh@kernel.crashing.org, linux-kernel@hansmi.ch,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] framebuffer: Remove old radeon driver
References: <20060127231314.GA28324@hansmi.ch>	<1138421392.30599.10.camel@localhost.localdomain> <20060127.204645.96477793.davem@davemloft.net>
In-Reply-To: <20060127.204645.96477793.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sat, 28 Jan 2006 15:09:52 +1100
> 
>> On Sat, 2006-01-28 at 00:13 +0100, Michael Hanselmann wrote:
> 
> The radeon_screen_blank() routine returns error codes back
> to the X server which handily confuses it, making it
> impossible to unblank the screen unless X has taken it
> all the way to power-off or somesuch.  The comment above
> this problematic code states:
> 
> 	/* let fbcon do a soft blank for us */
> 	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;
> 
> There has to be a better way to do this, which doesn't break
> X when run via fbcon. :-)
> 

The console layer has 5 blanking levels, with FB_BLANK_NORMAL defined
as "soft blank" (or blank the display without turning off display sync
signals) -- a console invention.  However, VESA has only 4 levels.

This can be easily fixed by incrementing the blank value by one if
the request originated from userspace.  I'll provide a patch
soon.

Tony
