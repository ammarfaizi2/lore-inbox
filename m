Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWB1KqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWB1KqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWB1KqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:46:08 -0500
Received: from tag.witbe.net ([81.88.96.48]:42922 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932166AbWB1KqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:46:06 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Jesse Brandeburg'" <jesse.brandeburg@intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <john.ronciak@intel.com>
Subject: Re: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Date: Tue, 28 Feb 2006 11:46:31 +0100
Organization: Witbe.net
Message-ID: <001101c63c54$3d02f040$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-reply-to: <Pine.WNT.4.63.0602271818570.284@jbrandeb-desk.amr.corp.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcY8DydoqC7YB5fdQva7U0aXK/YRmgAQ96og
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jesse,

>   					spddplx += (mii_reg & 0x100)
> -						   ? FULL_DUPLEX :
> -						   HALF_DUPLEX;
> +						   ? DUPLEX_FULL :
> +						   DUPLEX_HALF;

As I said in my first mail, I didn't want to go that way as one of the
two DUPLEX_FULL or DUPLEX_HALF is defined as being 0, which prevents
detecting incorrect/incomplete initializations.

The problem I had came from :
mii-tool -F 100BaseTx-FD eth0
when at the same time the ethtool interface was OK.

But you are right, the change I made missed the second caller.

The correct change is yours, though for the reason I put above, I think
it'll make it harder to spot other bugs ;)

Well done,
Paul

