Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUIKRsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUIKRsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIKRsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:48:39 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:58816 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S268239AbUIKRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:48:36 -0400
Message-ID: <41433A68.7090403@backtobasicsmgmt.com>
Date: Sat, 11 Sep 2004 10:48:24 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua> <20040910203046.GA19655@kroah.com> <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> Well, I lied a bit. These lines are from my home box, which is not
> udev'ified yet. At the job, I sit on i815 box, and there amixer
> fails to set volume. It happens 100% of the time. Adding "sleep 1"
> after modprobing helps. With devfs it worked without sleep.

This is correct; with devfs, creation of device nodes during module 
loading was synchronous, so it was always (or nearly always) complete 
before modprobe returned. With udev, creation of device nodes is 
completely asynchronous, and may happen at _any_ time after the module 
has been loaded.

The real solution here is for people to re-think their system startup 
processes; if you need mixer settings applied at startup, then build a 
small script somewhere in /etc/hotplug.d or /etc/dev.d that applies them 
to the mixer _when it appears_.
