Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUFSPMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUFSPMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUFSPMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:12:34 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:12423 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263942AbUFSPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:12:33 -0400
Date: Sat, 19 Jun 2004 16:11:53 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, James.Bottomley@SteelEye.com, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: DMA API issues... summary
Message-Id: <20040619161153.3be26806.spyro@f2s.com>
In-Reply-To: <1087603453.2135.224.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com>
	<40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
	<20040619002522.0c0d8e51.spyro@f2s.com>
	<1087601363.2078.208.camel@mulgrave>
	<20040619005106.15b8c393.spyro@f2s.com>
	<1087603453.2135.224.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, heres a summary of the problems we have (feel free to add any more problems).

We have two types of "device": single function devices and 'system on chip' devices which have multiple functions.

Single chip devices may be able to either access system memory directly, or may only be able to access their internal SRAM pool. in the case of the latter the system can either directly access the SRAM or not, depending on the device/bus setup. Its possible the devices may have more than one non-continuous SRAM mapping.

The same goes for SOC devices, however they could come in two 'classes'. In one type, we would essentially have multiple independant devices in a single chip. In another case (which appears to be fairly common) we can have multiple devices sharing a common SRAM pool. its also possible to have some devices sharing the pool and some having their own in the same chip.

Can anyone describe another type of chip we need to accomodate?



