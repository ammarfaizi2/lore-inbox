Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVKXJwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVKXJwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVKXJwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:52:49 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:45040 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S932604AbVKXJws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:52:48 -0500
Message-ID: <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>
In-Reply-To: <1132807985.1921.82.camel@mindpipe>
References: <1132807985.1921.82.camel@mindpipe>
Date: Thu, 24 Nov 2005 10:52:38 +0100 (CET)
Subject: Re: 2.6.14-rt4: via DRM errors
From: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Dave Airlie" <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I noticed these in dmesg after running "glxgears":
>
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
> [drm:via_pci_cmdbuffer] *ERROR* via_pci_cmdbuffer called without lock held
> [drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
>
> I was able to intermittently reproduce the messages by launching
> glxgears and moving the window around.
>
> Lee
>
>

I made a fix to the locking code in main drm a couple of months ago.

The X server tries to get the DRM_QUIESCENT lock, but when the wait was
interrupted by a signal (like when you move a window around), the locking
function returned without error. This made the X server release other
clients' locks.

This does affect all drivers with a quiescent() function. Not only via.

But it looks like this fix never made it into the kernel source?
Dave?

/Thomas





>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>


