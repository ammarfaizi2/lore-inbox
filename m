Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUJZQJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUJZQJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUJZQIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:08:53 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:8372 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261322AbUJZQI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:08:26 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Date: Tue, 26 Oct 2004 09:05:14 -0700
User-Agent: KMail/1.6.2
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20041026172843.6ac07c1a.colin@colino.net>
In-Reply-To: <20041026172843.6ac07c1a.colin@colino.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410260905.14869.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 08:28, Colin Leroy wrote:
> Hi,
> 
> 2.6.10-rc1 gives the following error messages on my iBook G4, which uses
> the ohci-hcd driver:
> 
> usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb2: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb3: usbfs: USBDEVFS_CONTROL failed cmd usbmodules rqt 128 rq 6 len 18 
ret -113
> usb usb3: string descriptor 0 read error: -113
> usb usb3: string descriptor 0 read error: -113
> usb usb3: string descriptor 0 read error: -113
> usb usb2: string descriptor 0 read error: -113
> usb usb2: string descriptor 0 read error: -113
> ...
> usb usb2: string descriptor 0 read error: -113
> usb usb2: string descriptor 0 read error: -113

What's wrong there is emitting voluminous diagnostics for
something that's not an error ... the root hub is suspended,
and as with any suspended device, you can't talk to it.

The descriptor read logic can skip retries in that case, and
usbfs should refuse up front to talk to suspended devices.
(Silently!)

- Dave


