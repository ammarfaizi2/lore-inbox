Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWEOG5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWEOG5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 02:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWEOG5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 02:57:21 -0400
Received: from e-nvb.com ([69.27.17.200]:52426 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932351AbWEOG5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 02:57:20 -0400
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
From: Arjan van de Ven <arjan@infradead.org>
To: HighPoint Linux Team <linux@highpoint-tech.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <041901c677e7$fdd9fbf0$1200a8c0@GMM>
References: <200605122209.k4CM95oW014664@mail.hypersurf.com>
	 <041901c677e7$fdd9fbf0$1200a8c0@GMM>
Content-Type: text/plain
Date: Mon, 15 May 2006 08:56:35 +0200
Message-Id: <1147676215.3121.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 14:22 +0800, HighPoint Linux Team wrote:
> Could you give more explanation about pci posting flush? When (and why) do we need it?

pci posting is where the chipset internally delays (posts) writes (as
done by writel and such) to see if more writes will come that can then
be combined into one burst. While in practice these queues are finite
(and often have a timeout) it's bad practice to depend on that. The
simplest way to flush out this posting is to do a (dummy) readl() from
the same device. (alternative is to do dma from the device to ram, but
readl() is a lot easier ;)

> In an old posting (http://lkml.org/lkml/2003/5/8/278) said pci posting flush is unnecessary - is it correct?

no not really, not as a general statement.


