Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVBVXTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVBVXTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVBVXTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:19:15 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:11909 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261331AbVBVXRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:17:22 -0500
Message-ID: <421BBD75.6040504@nortel.com>
Date: Tue, 22 Feb 2005 17:17:09 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com> <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl> <421B9C86.8090800@nortel.com> <Pine.LNX.4.61.0502221619330.5460@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502221619330.5460@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> Now, somebody needs a resource. It executes down(&semaphore);
> once it gets control again, it has that resource. It attempts
> to use that resource through a driver. The driver waits forever.
> The resource is now permanently dorked --forever because its
> driver is waiting forever. The user code never returns from
> the driver so it can never execute up(&semaphore).

What about something like a "robust mutex" (in OSDL terminology)?  The 
guy holding it too long gets killed, and the mutex gets marked as dirty. 
  The next guy to aquire the mutex is responsable for re-initializing 
the resource (resetting the device to a known state, for instance).

Chris

