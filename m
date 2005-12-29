Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVL2UMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVL2UMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVL2UMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:12:51 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:48266 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750946AbVL2UMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:12:50 -0500
From: David Brownell <david-b@pacbell.net>
To: ddstreet@ieee.org
Subject: Re: EHCI TT bandwidth (was Re: [PATCH] USB_BANDWIDTH documentation change)
Date: Thu, 29 Dec 2005 12:12:45 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org> <200512270857.35505.david-b@pacbell.net> <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
In-Reply-To: <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512291212.46348.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 December 2005 11:41 am, Dan Streetman wrote:
> 
> On Tue, 27 Dec 2005, David Brownell wrote:
> 
> >(*) The issues folk have mentioned with bandwidth reservation for
> >    EHCI are more "full and low speed devcies can't use all the
> >    available transaction translator bandwidth" than anything else.
> 
> The patches I just sent to the linux-usb-devel list (couple days ago) take
> care of those scheduling restrictions...do you have any comments on them?

Those are the ones I was thinking of, yes.  I need to make time to
look at those (even try them out!) but I don't have it just now.

Though I did notice you were using microframe "7" as an error code;
best to have some #defined constant, and one that would later allow
for use of FSTN nodes in the periodic schedule.

If other folk sent testing reports in, that'd help.  It'd affect
full speed devices down-stream of high speed hubs, when they use
isochronous transfers (audio, video) or interrupt ones (mostly
hubs and input devices like keyboards, mice, tablets).  And the
test cases of most interest would include several of those being
used at the same time ... 


> It would be great to get them in the kernel so EHCI can fully schedule any
> lowspeed or fullspeed buses that it manages.  I even put the changes 
> inside a kernel CONFIG option so people can test out the patches fully 
> before replacing the old model.

I'll likely OK that for merge into 2.6.16 without the Kconfig option.
Just replace the old scheduling with the newer stuff; no point in
trying to sort out two different sets of hard-to-track lowlevel bugs.

- Dave

