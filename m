Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSFTRFg>; Thu, 20 Jun 2002 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFTRFf>; Thu, 20 Jun 2002 13:05:35 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:40391 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S315416AbSFTRFe>; Thu, 20 Jun 2002 13:05:34 -0400
Date: Thu, 20 Jun 2002 10:07:23 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCHlet] 2.5.23 usb, ide
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <3D120BCB.8080701@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <UTC200206201616.g5KGG0J08669.aeb@smtp.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Earlier, I reported an oops at shutdown. I just looked at
> what causes the oops and find that the call
> 	hcd->driver->stop()
> is executed while hcd->driver->stop is NULL.
> 
> ...
> USB people may worry whether hcd->driver->stop should
> have been non-NULL.

Not supposed to be possible.  All those hc_driver structures
are declared "static const", with non-null stop().  Looks like
something was zeroing some driver's readonly data segment while
it was still in use.  (And who knows that else!)

What driver was getting that treatment?

- Dave



