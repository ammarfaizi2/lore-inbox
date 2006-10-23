Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWJWG0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWJWG0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWJWG0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:26:24 -0400
Received: from relay00.pair.com ([209.68.5.9]:25362 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751058AbWJWG0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:26:23 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
Date: Mon, 23 Oct 2006 01:25:47 -0500
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
In-Reply-To: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230126.10773.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 00:40, Giridhar Pemmasani wrote:
> It seems that the kernel module loader taints ndiswrapper module as
> proprietary, but it is not - it is fully GPL: see
> http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html

Indeed. 'ndiswrapper' is intentionally tainted by kernel/module.c because it 
is used to load and run unknown binary / proprietary code in kernel-space. If 
this unknown binary / proprietary code were to contain a bug (which all code 
of that complexity tends to), it might write to memory it doesn't own, or 
coerce a device to do so on its behalf, making a kernel crash dump analysis 
into a wild goose chase (hence the reason for kernel taint).

> Note that when a driver is loaded, ndiswrapper does taint the kernel (to be
> more accurate, it should check if the driver being loaded is GPL or not,
> but that is not done).

Are you saying ndiswrapper voluntarily calls add_taint() whenever it loads an 
NDIS driver?

Are there even any examples of GPL-licensed NDIS drivers?

> Thanks,
> Giri
>

Thanks,
Chase
