Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVCXJHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVCXJHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCXJHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:07:47 -0500
Received: from a83-68-3-130.adsl.cistron.nl ([83.68.3.130]:7941 "EHLO
	gw.wurtel.net") by vger.kernel.org with ESMTP id S261447AbVCXJHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:07:35 -0500
Date: Thu, 24 Mar 2005 10:07:19 +0100
From: Paul Slootman <paul+nospam@wurtel.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md: bug in file drivers/md/md.c, line 1513
Message-ID: <20050324090719.GA11613@wurtel.net>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <d1pi21$gjq$1@news.cistron.nl> <16961.60764.827542.318291@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16961.60764.827542.318291@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
X-Scanner: exiscan *1DEOJE-0000nW-00*FzKHOpvuyzQ*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Mar 2005, Neil Brown wrote:
> On Tuesday March 22, paul+nospam@wurtel.net wrote:
> > This is on kernel 2.6.11, mdadm 1.4.0
> > 
> > The system has MD devices that are auto-configured on boot.
> > 
> > However, there are also devices connected via another SCSI adapter
> > (actually, a Qlogic QLA2300). I'm using a module for that. As the
> > auto-configure only runs at boot (or rather, when the md subsystem is
> > started).  I wanted to restart a raid-0 device that I had previously
> > created. I did:
> > 
> > 	mdadm --run /dev/md10
> 
> As you admit, this is wrong.  You want something like
>   mdadm --assemble /dev/md10 /dev/.....(list of component devices)
> 
> or describe the md10 array (e.g. via UUID) in /etc/mdadm.conf

It took a bit of trial and error (I find the mdadm docs a bit
confusing...) but I came up with this:

mdadm --assemble --super-minor=10 --config=partitions /dev/md10


> > error message in the subject, and a "COMPLETE RAID STATE PRINTOUT"...
> > In that output there is a line "md10:", the next line is
> > "md1: <sde1><sdd1><sdc1><sdb1><sda1>".
> > 
> > 
> > Admittedly the usage may be wrong, but having the kernel say "bug" can't
> > be right :-)
> > 
> 
> Yes, there are quite a few of those silly bug messages.  I've removed
> a few, but have not yet gone through and checked and removed all the
> bad ones.

Keep up the good work :-)


Paul Slootman
