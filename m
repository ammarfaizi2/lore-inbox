Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVF3Anz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVF3Anz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVF3Anz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:43:55 -0400
Received: from smtpout6.uol.com.br ([200.221.4.197]:27531 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262760AbVF3Anw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:43:52 -0400
Date: Wed, 29 Jun 2005 21:43:49 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: stefanr@s5r6.in-berlin.de
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       akpm@osdl.org, bcollins@debian.org
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050630004349.GA1405@ime.usp.br>
Mail-Followup-To: stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, akpm@osdl.org,
	bcollins@debian.org
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <42C0FF50.7080300@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C0FF50.7080300@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2005, Stefan Richter wrote:
> If the node with the highest ID does not fulfill certain criteria, Linux 
> tries to get the highest ID moved to the local node. This function is 
> unrelated to SBP-2 (it is necessary to let streaming devices like 
> cameras work) but it has been observed that it disturbs a few SBP-2 
> devices. But again, I don't see how -mm and the stock kernel should 
> differ to that respect.

Well, my observation is that they differ. Well, up to kernel 2.6.13-rc1.
This latest kernel shows the same behaviour that -mm showed, unfortunately.

> You could load ieee1394 with a new parameter that supresses the "Root 
> node is not cycle master capable..." routine:
> # modprobe ieee1394 disable_irm=1
> before ohci1394 and the other 1394 related drivers are loaded.

Now *this* made things work! I have put another dmesg log on my homepage at
http://www.ime.usp.br/~rbrito/bug/ (see the 3rd-try log). This made things
work and I could mount the device.

I had to disable hotplug and udev, since trying to unload the Firewire
modules made my machine hang (I think that it was trying to unload ohci1394
that made my machine hang).

So, does this ring any bell? Can I provide extra information?

I am keeping the following diff just for reference's sake:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> SCSI subsystem initialized
> sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
>@@ -300,14 +308,6 @@
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
>   Vendor: ST316002  Model: 1A                Rev: 3.06
>-  Type:   Direct-Access                      ANSI SCSI revision: 06
>-SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>-sda: asking for cache data failed
>-sda: assuming drive cache: write through
>-SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>-sda: asking for cache data failed
>-sda: assuming drive cache: write through
>- sda: [mac] sda1 sda2 sda3 sda4
>-Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>+  Type:   Unknown                            ANSI SCSI revision: 04
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Thanks for all your kind responses, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
