Return-Path: <linux-kernel-owner+w=401wt.eu-S1030229AbWLTSPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWLTSPO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWLTSPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:15:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030229AbWLTSPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:15:12 -0500
Message-ID: <45897CAC.1050905@redhat.com>
Date: Wed, 20 Dec 2006 13:10:52 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] Add driver for OHCI firewire host controllers.
References: <fa.4xX+iXSBwItlW4ONHWvAYR6m5+c@ifi.uio.no> <4588BA0E.1080801@shaw.ca>
In-Reply-To: <4588BA0E.1080801@shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Kristian Høgsberg wrote:
...
>> +static struct pci_driver fw_ohci_pci_driver = {
>> +    .name        = ohci_driver_name,
>> +    .id_table    = pci_table,
>> +    .probe        = pci_probe,
>> +    .remove        = pci_remove,
>> +};
> 
> How about suspend/resume support? Lots of laptops have OHCI 1394 and 
> full suspend/resume support is something that the current ohci1394 
> driver lacks.

Yes, good point, that needs to work too.  What I'm thinking here is that we 
need to turn off the link-on bit in the self ID packets we send out and then 
generate a bus reset before we suspend.  It shouldn't be necessary to change 
upper level drivers, the SBP-2 driver should just remaind logged in to the 
storage device.  When resuming, we re-enable the link-on bit and do a bus 
reset again, and should be back in operation.

Kristian


