Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVI2P6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVI2P6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVI2P6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:58:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54725 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932167AbVI2P6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:58:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <433C0EBF.7080605@s5r6.in-berlin.de>
Date: Thu, 29 Sep 2005 17:56:47 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: James.Smart@Emulex.Com, hch@infradead.org, jgarzik@pobox.com,
       joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, axboe@suse.de, torvalds@osdl.org,
       rdunlap@xenotime.net
Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of Jens'
 SATA suspend-to-ram patch)
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C21D7AC2@xbl3.ma.emulex.com>
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C21D7AC2@xbl3.ma.emulex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.126) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I admit I haven't studied the patches. Anyway, here is what I have to 
say about what I (mis?)understood from your posts:

James Smart wrote:
> You need to be careful on the power-up. Many JBODs share a single
> "enclosure" and that enclosure has a limited power supply. If all
> drives were spun up in parallel (and a drive may take 10-15seconds
> to spin up), then they can overload the enclosure's power limit.
[...]
> There were not a lot of great answers on how to solve this as it usually
> required knowledge of how the hardware was packaged.
[...]

>>On Thu, Sep 29, 2005 at 08:34:37AM +0100, Christoph Hellwig wrote:
>>>is an ULDD operation, not an LLDD one, and this fits the layering model
>>>much better.

The operation _involves_ the high level, yes. But whether it may be/ 
must not be performed has to be controlled by the transport layer. Take 
FireWire as an example: IEEE 1394(a,b) has power management 
specifications. (NB: Its indeed in IEEE 1394, not in the SBP-2 spec.) 
One rule is that only one node on a FireWire bus may perform power 
management; the node which is allowed to do this is determined by a 
special protocol.

>>Actually one important thing is missing, that is a way to avoid spinning
>>down external disks.  As a start a sysfs-controlable flag should do it,
>>later we can add transport-specific ways to find out whether a device
>>is external.

It is not a question of external vs. internal, at least not if you 
consider more than SATA. Power management is the genuine task of 
transport layers (specifically, of transport management layers). These 
layers might need assistence from SCSI high-level protocol layer though.

IOW it's certainly correct to provide suspend/resume helpers in SCSI 
high level (probably abstracted through SCSI core), but whether these 
helpers are called or not has to be decided down in the SCSI low level, 
or even further beneath that level.
-- 
Stefan Richter
-=====-=-=-= =--= ===-=
http://arcgraph.de/sr/
