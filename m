Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTAOVxE>; Wed, 15 Jan 2003 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTAOVxE>; Wed, 15 Jan 2003 16:53:04 -0500
Received: from h-64-105-35-200.SNVACAID.covad.net ([64.105.35.200]:15232 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267372AbTAOVxD>; Wed, 15 Jan 2003 16:53:03 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 15 Jan 2003 14:01:36 -0800
Message-Id: <200301152201.OAA02047@adam.yggdrasil.com>
To: mochel@osdl.org
Subject: Re: Patch: linux-2.5.58/drivers/base/bus.c ignored pre-existing devices
Cc: felix-linuxkernel@fefe.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       tomlins@cam.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-01-15, Patrick Mochel wrote:
>The extra code was an attempt at properly handling failure of ->probe(),
>and to make sure that an error from ->probe() (e.g. -ENOMEM) is propogated
>up.
>
>The cause of the problem you're seeing is that if a device wasn't bound to 
>a driver, -ENODEV was returned, causing it to be removed from the bus's 
>list of devices. 
>
>To remedy this, I've changed the semantics of bus_match() to return the 
>following:
>
>* 1     if device was bound to a driver.
>* 0     if it wasn't 
>* <0    if drv->probe() returned an error. 
>
>This allows the caller to know if binding happened, as well as bubble the 
>error up.

	I have't tried your patch, but, from reading it, I infer that
your patch would not work with drivers that do further matching
in their probe function and return -ENODEV, which should be handled
as if match() function failed.  I suggest you use my patch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
