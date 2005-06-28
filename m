Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVF1HuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVF1HuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVF1Hql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:46:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:23204 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261648AbVF1Hmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:42:33 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42C0FF50.7080300@s5r6.in-berlin.de>
Date: Tue, 28 Jun 2005 09:42:08 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Reply-To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: Problems with Firewire and -mm kernels
References: <20050626040329.3849cf68.akpm@osdl.org>	<42BE99C3.9080307@trex.wsi.edu.pl>	<20050627025059.GC10920@ime.usp.br>	<20050627164540.7ded07fc.akpm@osdl.org>	<20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org>
In-Reply-To: <20050627202226.43ebd761.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.554) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> -ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
> +ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0050c501e00010e8]
> +ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> +ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>  ieee1394: Node changed: 0-00:1023 -> 0-01:1023

The IDs are assigned to nodes everytime they are attached to the bus in 
a random order. It is a pure hardware thing; I cannot imagine any 
influnce of the kernel to this procedure.

If the node with the highest ID does not fulfill certain criteria, Linux 
tries to get the highest ID moved to the local node. This function is 
unrelated to SBP-2 (it is necessary to let streaming devices like 
cameras work) but it has been observed that it disturbs a few SBP-2 
devices. But again, I don't see how -mm and the stock kernel should 
differ to that respect.

You could load ieee1394 with a new parameter that supresses the "Root 
node is not cycle master capable..." routine:
# modprobe ieee1394 disable_irm=1
before ohci1394 and the other 1394 related drivers are loaded.

>  SCSI subsystem initialized
>  sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> @@ -300,14 +308,6 @@
>  ieee1394: sbp2: Logged into SBP-2 device
>  ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
>    Vendor: ST316002  Model: 1A                Rev: 3.06
> -  Type:   Direct-Access                      ANSI SCSI revision: 06
> -SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> -sda: asking for cache data failed
> -sda: assuming drive cache: write through
> -SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> -sda: asking for cache data failed
> -sda: assuming drive cache: write through
> - sda: [mac] sda1 sda2 sda3 sda4
> -Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> +  Type:   Unknown                            ANSI SCSI revision: 04

There was a discussion in May about discovery of devices which implement 
the RBC command set: http://marc.theaimsgroup.com/?t=111620896500001 I 
am not sure if the discussed change went into one or both of the kernels 
in question.

>  ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>  ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]

What caused these two messages? Did you disconnect the drive at this point?
-- 
Stefan Richter
-=====-=-=-= -==- ===--
http://arcgraph.de/sr/
