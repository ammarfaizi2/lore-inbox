Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUBKBRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBKBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:17:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:5068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263618AbUBKBQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:16:15 -0500
Date: Tue, 10 Feb 2004 17:16:00 -0800
From: Greg KH <greg@kroah.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211011559.GA2153@kroah.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com> <20040210203900.GA18263@ti19.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210203900.GA18263@ti19.telemetry-investments.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:39:00PM -0500, Bill Rugolsky Jr. wrote:
> On Tue, Feb 10, 2004 at 01:11:36PM -0700, Kevin P. Fleming wrote:
> > devfs is "single-instance": it can be mounted during initrd/initramfs 
> > processing, then remounted after pivot_root without losing its contents
> > 
> > Granted, I'm sure someone can come up with a single-instance ramfs 
> > filesystem that can be used for udev, but today it does not exist.
>  
> mount --move olddir newdir

Doesn't work for what we want here:

	$ mkdir /tmp/a /tmp/b
	$ mount -t ramfs none /tmp/a
	$ touch /tmp/a/foo
	$ mount --move /tmp/a /tmp/b
	$ ls /tmp/b
	foo
	$ umount /tmp/a
	$ ls /tmp/b
	$ 

Hm, not nice :(

thanks,

greg k-h
