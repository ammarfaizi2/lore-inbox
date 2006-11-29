Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934367AbWK2FzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934367AbWK2FzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934372AbWK2FzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:55:10 -0500
Received: from castle.comp.uvic.ca ([142.104.5.97]:15780 "EHLO
	castle.comp.uvic.ca") by vger.kernel.org with ESMTP id S934367AbWK2FzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:55:09 -0500
Message-ID: <456D2094.70504@uvic.ca>
Date: Tue, 28 Nov 2006 21:54:28 -0800
From: Evan Rempel <erempel@uvic.ca>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI init discussion/SAN problem (not interesting)
References: <E1GoshR-0003To-00@calista.eckenfels.net>
In-Reply-To: <E1GoshR-0003To-00@calista.eckenfels.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-UVic-Virus-Scanned: OK - Passed virus scan by Sophos (sophie) on castle
X-UVic-Spam-Scan: castle.comp.uvic.ca Not_scanned_LOCAL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <456B8EBC.7070801@uvic.ca> you wrote:
> 
>>Was this post just not interesting enough, or is it the lack of access to hardware
>>to test this on that prevented it from being picked up by someone?
> 
> 
> see google, for example: http://christophe.varoqui.free.fr/multipath.html
> 

While that information is accurate, it is not new to me.

I must have been unclear in my description of how the scsi device registration
with the kernel causes multipath devices to function inefficiently.

When a device has multiple paths, the kernel will see multiple scsi devices, even
though there is only one physical device. For each of the scsi devices that the
kernel can see, the partition table (or some other IO that I am unaware of) is
read from the device, meaning IO is generated on ALL paths to the device. This isn't
a problem for some devices, but on others it can initiate a failover process which can
take many seconds, only to have the process repeated as IO is generated on a third path to
the device.

Is it unreasonable for the scsi initialization routines to be aware that some kernel scsi
devices are really the same physical devices and register them with the kernel WITHOUT
generating any IO on the physical device?

Doing this there would be a maximum of one failover per physical device durint the boot
sequence. This one failover could be eliminated if the scsi initialization code were aware
of "active" paths and only generated IO on active paths, rather than the first path.

All of this is before device mapper or multipath get thier hands on the scsi devices. It is
completely within the scope of the scsi initialization code in the kernel.

Is this more clear? If not, could someone ask for clearification of the fuzzy parts?

Evan.
