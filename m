Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTJKAg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 20:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbTJKAg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 20:36:56 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:19374 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263178AbTJKAgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 20:36:55 -0400
Message-ID: <3F87523A.1030100@pacbell.net>
Date: Fri, 10 Oct 2003 17:43:38 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB fixes for 2.6.0-test7
References: <20031010231820.GA18566@kroah.com>
In-Reply-To: <20031010231820.GA18566@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> ...  Oh, and suspend now works for USB devices, thanks to Paul :)

And on some systems, the resume path even works ... :)

The D3cold resume path -- which should behave very much
like resuming from software suspend -- can be made to
self-deadlock in some cases:  dpm_sem is held while the
resume callbacks are made, so they deadlock when calls to
device_del (for getting rid of the old device tree) try
to grab the same lock.

So don't get your hopes up too far yet -- but yes,
that usbcore patch does help some configs a bunch.

- Dave



