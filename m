Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUBKBl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUBKBl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:41:27 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:31621 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261506AbUBKBlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:41:25 -0500
Message-ID: <4029883C.2070705@backtobasicsmgmt.com>
Date: Tue, 10 Feb 2004 18:41:16 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com> <20040210203900.GA18263@ti19.telemetry-investments.com> <20040211011559.GA2153@kroah.com>
In-Reply-To: <20040211011559.GA2153@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Doesn't work for what we want here:
> 
> 	$ mkdir /tmp/a /tmp/b
> 	$ mount -t ramfs none /tmp/a
> 	$ touch /tmp/a/foo
> 	$ mount --move /tmp/a /tmp/b
> 	$ ls /tmp/b
> 	foo
> 	$ umount /tmp/a
> 	$ ls /tmp/b
> 	$ 

That seems very odd, the "umount /tmp/a" should have failed, given than 
nothing is mounted there any longer.

Also, what will happen if something on the filesystem on /tmp/a is open 
(say, /dev/console)? I was thinking that this process might work better:

$ mkdir /tmp/a /tmp/b
$ mount -t ramfs test /tmp/a
$ touch /tmp/a/foo
$ mount --bind /tmp/a /tmp/b
$ ls /tmp/b
foo
$ umount /tmp/a
$ ls /tmp/b
foo


And it does. In fact, it seems to work fine as long as no files are open 
on the ramfs when the umount is executed (otherwise -EBUSY).


