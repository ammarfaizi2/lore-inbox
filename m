Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbRERIYE>; Fri, 18 May 2001 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262275AbRERIXy>; Fri, 18 May 2001 04:23:54 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:21992 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S262273AbRERIXj>; Fri, 18 May 2001 04:23:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Brian Wheeler <bdwheele@wombat.educ.indiana.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Fri, 18 May 2001 10:24:16 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200105172000.f4HK00V19810@wombat.educ.indiana.edu>
In-Reply-To: <200105172000.f4HK00V19810@wombat.educ.indiana.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01051810241601.00782@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 May 2001 22:00, Brian Wheeler wrote:
> Consider an ID consisting of:
> 	* vendor
> 	* model

Vendor and model ids are available for PCI and USB devices, but I think you 
can not assume that all busses have them and you dont gain anything if you 
keep them separate (unless you want to interpret the fields of the device id).
In other words I would merge them into a single field.

> 	* serial number
> 	* content-cookie
> 	* topology-cookie

You need another field that contains a identifier for the bus or the scheme 
of the device id, because different busses use different formats and you 
cannot compare them.

You could also merge content-cookie and serial number because you will always 
to interpret them together. 

>   I suppose these ID fields could also be used by a userspace tool to
>   load/unload drivers as necessary.

There is a problem with that idea: you often cannot generate the device id 
before the driver is available. Things like the content cookie and the serial 
number must be created by the driver, at least in some cases. For example a 
PCI ethernet card has a great serial number, its hardware address, but you 
can only get it after the driver has been loaded.

bye...
