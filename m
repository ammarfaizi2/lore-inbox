Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTJKSqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTJKSqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:46:37 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:7397 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263355AbTJKSqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:46:37 -0400
Message-ID: <3F8851A7.3000105@pacbell.net>
Date: Sat, 11 Oct 2003 11:53:27 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Peter Matthias <espi@epost.de>, linux-kernel@vger.kernel.org
CC: linux-usb-devel@lists.sourceforge.net
Subject: Re: ACM USB modem on Kernel 2.6.0-test
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> usb 3-3: configuration #1 chosen from 2 choices
> drivers/usb/class/cdc-acm.c: need inactive config #2
> drivers/usb/class/cdc-acm.c: need inactive config #2

Until we get more intelligence somewhere, do this:

    # cd /sys/bus/usb/devices/3-3
    # echo '2' > bConfigurationValue
    #

That makes the device use vendor-neutral protocols
to talk to the host, not MSFT-proprietary ones.  (It's
important to use the numbers from those messages; they
will change if you use different USB ports.)

Hmm ... maybe usbcore would be better off with a less
naive algorithm for choosing defaults.  Like, preferring
configurations without proprietary device protocols.
That'd solve every cdc-acm case, and likely others.

- Dave


