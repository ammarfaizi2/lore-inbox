Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWJTXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWJTXSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWJTXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:18:21 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:22663 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161035AbWJTXSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:18:21 -0400
Date: Sat, 21 Oct 2006 01:17:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jim <yh@bizmail.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel internal built in module loading order
In-Reply-To: <453953EC.3000407@bizmail.com.au>
Message-ID: <Pine.LNX.4.61.0610210114170.10103@yvahk01.tjqt.qr>
References: <453953EC.3000407@bizmail.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does the kernel load internal built in modules (obj-y) in a certain 
> order,

Yes. As far as I can tell:

- special ordering (when you find __define_initcall in the 
kernel source, you know)

and

- linking order

play a role.

> or
> in a random order? Does the kernel internal module loading based on a
> configuration file?

/etc/modprobe.conf, but the proper answer would be "no".

> I am running an ARM system, is there a way to delay the Ethernet 
> module loading
> until some other internal modules are loaded?

I am sure you can use some modprobe magic, such as:

  install 8139too /usr/local/bin/my-8139-loader

And your 8139-loader contains:

  #!/bin/bash

  while ! condition; do
	sleep 1;
  done;
  modprobe 8139too;

I just don't know how well that fares when you are trying to modprobe 
from within modprobe.


	-`J'
-- 
