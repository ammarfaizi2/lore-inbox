Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUDBUzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 15:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbUDBUzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 15:55:25 -0500
Received: from A88be.a.pppool.de ([213.6.136.190]:24706 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S264176AbUDBUzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 15:55:19 -0500
Message-ID: <406DD2E2.7030602@A88be.a.pppool.de>
Date: Fri, 02 Apr 2004 22:53:54 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>	<20040328200710.66a4ae1a.akpm@osdl.org>	<4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>	<1080570227.20685.93.camel@watt.suse.com>	<406D21F6.8080005@A88c0.a.pppool.de> <20040402022348.00d55268.akpm@osdl.org>
In-Reply-To: <20040402022348.00d55268.akpm@osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andreas Hartmann <andihartmann@freenet.de> wrote:
>>
>> Now, I tested 2.6.5-rc3-mm4. Same procedure.
>>  The good news first:
>>  2.6.5-rc3-mm4 is nearly as fast as 2.4.25 - it is about 2% slower than 
>>  2.4.25 (with preemption turned on).
>> 
>>  Now the bad news:
>>  The system-processor-time is unchanged abnormal high: it is 34% (!) higher 
>>  than in 2.4.25 (and about 1% more than in 2.4.6).
>> 
>> 
>>  Btw: Did the other profile outputs help to find the problem?
>> 
>>  These are the profile-values for an example run (make of kernel 2.6.5rc2) 
>>  with 2.6.5rc3mm4:
> 
> Spending a lot of time on do_softirq() while compiling stuff is peculiar.
> 
> What device drivers are running at the time?  disk/network/usb/etc?

Module                  Size  Used by    Not tainted
eepro100               19828   1  (autoclean)
mii                     2480   0  (autoclean) [eepro100]
sis900                 13036   1  (autoclean)
crc32                   2880   0  (autoclean) [sis900]
usb-storage            26416   0  (unused)
scsi_mod               87488   0  [usb-storage]
uhci                   25436   0  (unused)
usbcore                62316   0  [usb-storage uhci]
lvm-mod                44416  12  (autoclean)
unix                   15308  13  (autoclean)

These are all modules (drivers), which are running - in both cases (2.4.25 
and 2.6.x).


Regards,
Andreas Hartmann
