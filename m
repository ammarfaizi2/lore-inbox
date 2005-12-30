Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVL3SSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVL3SSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVL3SSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:18:42 -0500
Received: from [81.2.110.250] ([81.2.110.250]:15765 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751274AbVL3SSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:18:41 -0500
Subject: Re: RAID controller safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051230161805.64631.qmail@web34110.mail.mud.yahoo.com>
References: <20051230161805.64631.qmail@web34110.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Dec 2005 18:20:30 +0000
Message-Id: <1135966830.28365.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-30 at 08:18 -0800, Kenny Simpson wrote:
> That's what I read in the comments too, but looking at the code I only ever see it set to
> write-back.  I verified this with blktool - our controllers have no battery, and blktool showed
> the i2o-wcache state as write-back.

blktool doesn't support i2o control as far as I am aware. The blk level
generic ioctls are just too crude to control it properly.

> However, I was also told that the i2o_block driver lacks barrier support, so even in the
> write-back case, the controller won't be told to flush/sync.

Correct, but it should only ever enable this in the battery backed case.
Otherwise it uses the per command control bits to decide what mode it
wishes to use for each I/O

