Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUCPPWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbUCPPUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:20:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:699 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262917AbUCPPR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:17:57 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: deactivate dm disks?
Date: Tue, 16 Mar 2004 09:17:03 -0600
User-Agent: KMail/1.6
Cc: EVMS <evms-devel@lists.sourceforge.net>, Wakko Warner <wakko@animx.eu.org>
References: <20040315205650.A11865@animx.eu.org>
In-Reply-To: <20040315205650.A11865@animx.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403160917.03810.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wakko,

On Monday 15 March 2004 7:56 pm, Wakko Warner wrote:
> I was playing with evms (2.2 kernel 2.6.3 vanilla) and some reason, it
> grabbed my usb disk (sde) and won't let go of it.  Is there any way I can
> make it let go of the disk?  It grabbed sde1 and sde2 of the disk.

You can put entries in your /etc/evms.conf file to tell EVMS to ignore certain 
disks (e.g. if you don't want it to examine sde). See the "legacy_devices" 
section (for 2.4 kernels) and/or the "sysfs_devices" section (for 2.6 
kernels).

> I tried the deactivate which just gave me an invalid argument. I really do
> not wish to reboot this machine just to remove the usb disk.

If you have the "dmsetup" tool, you can issue a "dmsetup remove_all" command 
to deactivate all the DM devices. Just make sure all the DM devices are 
unmounted, or it won't actually release the underlying disks. Dmsetup is part 
of the device-mapper package, available at ftp://sources.redhat.com/pub/dm/.

> I also noticed it wanted to grab my partitions on sda which were already
> mounted and couldn't grab them.

Again, you can add an "exclude" entry in your /etc/evms.conf if you want EVMS 
to ignore sda. Otherwise, have a look at
http://evms.sf.net/install/kernel.html#bdclaim

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
