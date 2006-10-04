Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161525AbWJDQHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161525AbWJDQHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWJDQHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:07:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11413 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161537AbWJDQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:07:28 -0400
Subject: Re: to many sockets ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Wenke <M.Wenke@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4523CD4E.10806@web.de>
References: <4523CD4E.10806@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 17:33:07 +0100
Message-Id: <1159979587.25772.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 17:03 +0200, ysgrifennodd Markus Wenke:
> Hi,
> 
> I wrote a program which handles incomming sockets asynchron.
> It can handle up to 140000 connections simultaneously while every 
> connection send some bytes in both directions continuously.

Armwavingly 64K x 2 per socket worst case for non tcp windowed buffering

128K per socket x 140000 connections

8750MB of RAM

plus other overhead

Assuming you kept the socket buffer limit to 64K by setting it or
disabling window scaling you'd want a about 10GB of RAM for the sockets,
buffering and resources. With tcp windows you'd need more.

If your data rates are always low, or the link is low latency you could
set the send/receive socket buffer for each connection via setsockopt
down to say 8K and come out needing perhaps 1GB or so instead.

You will also need a very fast network for that many connections just
for the cost of headers/ack frames.

Alan

