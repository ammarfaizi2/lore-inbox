Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUJGR24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUJGR24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUJGR24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:28:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:61599 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267702AbUJGRZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:25:49 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Stephen Hemminger <shemminger@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410070850480.10751@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
	 <1097143144.2789.19.camel@laptop.fenrus.com>
	 <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com>
	 <20041007121741.GB23612@devserv.devel.redhat.com>
	 <Pine.LNX.4.61.0410070823300.10118@chaos.analogic.com>
	 <20041007122815.GC23612@devserv.devel.redhat.com>
	 <Pine.LNX.4.61.0410070830140.10213@chaos.analogic.com>
	 <Pine.LNX.4.61.0410070850480.10751@chaos.analogic.com>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Thu, 07 Oct 2004 10:25:34 -0700
Message-Id: <1097169934.29576.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still haven't full source so this is still guess work.
But assuming it is a character device, did you forget to add an owner
field to the file ops structure?

static struct file_operations xxx_fops = {
	.owner	= THIS_MODULE,
	.read	= my_read,
...

The owner field is used by the character device layer to maintain module
ref counts in 2.6.



