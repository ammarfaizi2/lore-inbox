Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSFQIdg>; Mon, 17 Jun 2002 04:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSFQIdf>; Mon, 17 Jun 2002 04:33:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53508 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316844AbSFQIdf>; Mon, 17 Jun 2002 04:33:35 -0400
Date: Mon, 17 Jun 2002 09:33:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Soewono Effendi <seffendi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [off topic - RFC] APM suspend + hdparam
Message-ID: <20020617093331.A3367@flint.arm.linux.org.uk>
References: <200206170824.g5H8O3X25927@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200206170824.g5H8O3X25927@mailgate5.cinetic.de>; from seffendi@web.de on Mon, Jun 17, 2002 at 10:24:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:24:03AM +0200, Soewono Effendi wrote:
> So I tried this: 
> apm -s & hdparm -Y /dev/hda & 

If your APM BIOS doesn't spin down the disks when entering standby/suspend,
your APM BIOS implementation is broken (or if its a desktop machine, maybe
you didn't configure the APM BIOS settings correctly?)

You might try: hdparm -S 12 /dev/hda && apm -s; hdparm -S 0 /dev/hda

This should put a 1 minute inactivity timeout on the drive, then suspend
the machine.  1 minute later, the drive should spin down.  When you resume,
the following hdparm will turn off the inactivity timeout.

> I would like to call this feature HOT SUSPEND(TM) :) 

No coding required.  No extra commands required with a non-broken APM bios.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

