Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274996AbTHLCtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274991AbTHLCtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:49:07 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:55569 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S274990AbTHLCtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:49:04 -0400
Date: Tue, 12 Aug 2003 04:49:01 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Woods <kazrak+kernel@cesmail.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops in sd_shutdown
Message-ID: <20030812044901.A1650@pclin040.win.tue.nl>
References: <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <20030812002844.B1353@pclin040.win.tue.nl> <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail>; from kazrak+kernel@cesmail.net on Mon, Aug 11, 2003 at 06:13:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 06:13:50PM -0700, Jeff Woods wrote:

> Looking only at the above code snippet, I'd suggest something more like:

> +       if (!sdp || 


This is not meaningful.

A general kind of convention is that a pointer will be NULL either
by mistake, when it is uninitialized, or on purpose, when no object
is present or no action (other than the default) needs to be performed.

But that general idea is broken by container_of(), which just subtracts
a constant. So, one should check before subtracting that the pointer
is non-NULL. Checking afterwards is meaningless.

