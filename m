Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUBKMeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUBKMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:34:13 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:54176 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S264329AbUBKMeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:34:10 -0500
Date: Wed, 11 Feb 2004 07:33:52 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211123352.GA32657@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com> <20040210203900.GA18263@ti19.telemetry-investments.com> <20040211011559.GA2153@kroah.com> <20040211075049.GJ21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211075049.GJ21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 07:50:49AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Feb 10, 2004 at 05:16:00PM -0800, Greg KH wrote:
> > Doesn't work for what we want here:
> > 
> > 	$ mkdir /tmp/a /tmp/b
> > 	$ mount -t ramfs none /tmp/a
> > 	$ touch /tmp/a/foo
> > 	$ mount --move /tmp/a /tmp/b
> > 	$ ls /tmp/b
> > 	foo
> > 	$ umount /tmp/a
> > 	$ ls /tmp/b
> > 	$ 
> > 
> > Hm, not nice :(
> 
> Huh?  Is that a bug report or just your guess at what would happen if you
> tried the above?
> 
> If it _does_ happen - we have a problem and I'd like to know which versions
> have such bug.

Ugh, /etc/mtab really ought to die.

Anyway, with traditional /etc/mtab, mount --move produces:

   none on /tmp/a type ramfs (rw)
   /tmp/a on /tmp/b type none (rw)

ln -sf /proc/self/mounts /etc/mtab and retry, it works fine:

   none on /tmp/b type ramfs (rw)

I'll have a look at mount later today, if nobody else gets there first.

	-Bill
