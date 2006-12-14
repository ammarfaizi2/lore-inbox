Return-Path: <linux-kernel-owner+w=401wt.eu-S932684AbWLNMMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWLNMMJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWLNMMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:12:09 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1351 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932684AbWLNMMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:12:08 -0500
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 07:12:08 EST
Date: Thu, 14 Dec 2006 12:51:05 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214115105.GA8742@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org> <200612140949.43270.duncan.sands@math.u-psud.fr> <200612141056.03538.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612141056.03538.hjk@linutronix.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:56:03AM +0100, Hans-Jürgen Koch wrote:
> A small German manufacturer produces high-end AD converter cards. He sells
> 100 pieces per year, only in Germany and only with Windows drivers. He would
> now like to make his cards work with Linux. He has two driver programmers
> with little experience in writing Linux kernel drivers. What do you tell him?
> Write a large kernel module from scratch? Completely rewrite his code 
> because it uses floating point arithmetics?

Write a small kernel module which:
- create a device node per-card
- read the data from the A/D as fast as possible and buffer it in main
  memory without touching it
- implements a read interface to read data from the buffer
- implement ioctls for whatever controls you need

And that's it.  All the rest can be done in userspace, safely, with
floating point, C++ and everything.  If the driver programmers are
worth their pay, their driver is probably already split logically at
where the userspace-kernel interface would be.

And small means small, like 200 lines or so, more if you want to have
fun with sysfs, poll, aio and their ilk, but that's not a necessity.

  OG.

