Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTEPHyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTEPHyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 03:54:16 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:43730 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264366AbTEPHyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 03:54:14 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ranty@debian.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface, third round.
Date: Fri, 16 May 2003 10:07:31 +0200
User-Agent: KMail/1.5.1
Cc: Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
References: <20030515200324.GB12949@ranty.ddts.net>
In-Reply-To: <20030515200324.GB12949@ranty.ddts.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305161007.31335.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  How it works:
> 	- Driver calls request_firmware()
> 	- 'hotplug firmware' gets called with ACCTION=add
> 	- /sysfs/class/firmware/dev_name/{data,loading} show up.
>
> 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> 	- echo 0 > /sysfs/class/firmware/dev_name/loading
>
> 	- The call to request_firmware() returns with the firmware in a
> 	  memory buffer and the driver can finish loading.
> 	- Driver loads the firmware.
> 	- Driver calls release_firmware().

So, if I understand you correctly, RAM is only saved if a device
is hotpluggable and needs firmware only upon intial connection.
Which, if you do suspend to disk correctly, is no device.

And do I understand you correctly, you propose that request_firmware()
wait for the hotplug script to write the firmware to sysfs?
That means that request_firmware() is unusuable from the usual
probe() methods. You cannot kill a part of the kernel if a script
fails to perform correctly for some reason. Even worse, you
cannot detect the script terminating abnormally in that design.
You'd have to introduce some arbitrary timeout.

It seems to me that you introduce three new problems to get rid of
one old problem.

	Regards
		Oliver

