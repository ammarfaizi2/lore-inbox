Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbUK0Gr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUK0Gr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUK0Gr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:47:28 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:18910 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261788AbUKZTLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:11:03 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop
Date: Fri, 26 Nov 2004 09:21:26 -0800
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
References: <20041125191726.5ca95299@jack.colino.net> <200411260838.10508.david-b@pacbell.net> <20041126175454.17b62cf5@pirandello>
In-Reply-To: <20041126175454.17b62cf5@pirandello>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260921.26628.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 November 2004 08:54, Colin Leroy wrote:
> On 26 Nov 2004 at 08h11, David Brownell wrote:
> 
> Hi, 
> 
> > The infinite loop means that something trashed the stack, yes?
> > 
> > The "limit-- < -1000" test below should never be able to succeed
> > unless the previous "limit-- == 0" test got trashed by having
> > something obliterate the stack. 
> 
> Sure? the (limit -- == 0) gotoes higher to test again.
> from what I understand the loop goes back to rescan 1000 times, then once 
> to sanitize, then to back to rescan again infinetely...
> I may be wrong but I don't think there's a stack corruption there.

The "limit" isn't tested a 1001st time, since the ED state
changed.

For that matter, any time that the IRQ lossage appears,
there's always been something that damaged the IRQ setup.

- Dave

