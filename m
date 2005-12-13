Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVLMGw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVLMGw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVLMGw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:52:56 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:52840 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932389AbVLMGw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:52:56 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Mon, 12 Dec 2005 22:52:53 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20051211041308.7bb19454.akpm@osdl.org> <200512122053.39970.rjw@sisk.pl> <20051212122914.1bd36f32.akpm@osdl.org>
In-Reply-To: <20051212122914.1bd36f32.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512122252.53814.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {

What happens if you make that line read

	if ((status & STS_PCD) != 0) {

and ignore the root hub thing?  There's some confusion about when the root
hub becomes available ... it should be done a lot earlier than it is now,
like before any HCD code may need to rely on it.

- Dave

