Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVHRSlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVHRSlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVHRSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:41:12 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:6302 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932313AbVHRSlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:41:11 -0400
Date: Thu, 18 Aug 2005 20:41:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 2.6.13-rc6] watchdog: fix oops in softdog driver
Message-ID: <20050818184109.GB19487@infomag.infomag.iguana.be>
References: <200508180113_MC3-1-A77D-A127@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508180113_MC3-1-A77D-A127@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

>   The softdog watchdog timer has a bug that can create an oops:
> 
>   1.  Load the module without the nowayout option.
>   2.  Open the driver and close it without writing 'V' before close.
>   3.  Unload the module.  The timer will continue to run...
>   4.  Oops happens when timer fires.
> 
>   Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>
> 
>   Fix is easy: always take a reference on the module on open.
> Release it only when the device is closed and no timer is running.
> Tested on 2.6.13-rc6 using the soft_noboot option.  While the
> timer is running and the device is closed, the module use count
> stays at 1.  After the timer fires, it drops to 0.  Repeatedly
> opening and closing the driver caused no problems.  Please apply.

I'll add this to the watchdog tree.

Thanks,
Wim.

