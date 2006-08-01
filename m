Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWHASXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWHASXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWHASXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:23:13 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:10906 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751769AbWHASXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:23:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d6d4aOrx5BY6kcp1yxPEVmzlxd8am609bVAAFlPLQIl0FgAA9UlYkSRV8rx/Su2D7dUN6dqEMHqqudH6xXy0u9O8iILRocvnsWtwa6Ab1u+0IlgrLJruVqVcSmV0eSdS2AF59OsGFY3WrFzgYYda10keeoasa3IjzfIwO130qyg=
Message-ID: <44CF9C0A.8090405@gmail.com>
Date: Wed, 02 Aug 2006 03:23:06 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <44CF9A23.9090409@t-online.de>
In-Reply-To: <44CF9A23.9090409@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Tejun Heo wrote:
>> Can you try the following instead of hdparm?
>>
>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>>
>> It will make libata involved in putting the disk to sleep and waking it
>> up, and, when waking, it will kick the drive in the ass by resetting the
>> channel.  Please try with the latest -rc kernel.
>>
> 
> Sorry to say, but this did not work:
> 
> # echo 1 > /sys/bus/scsi/devices/0:0:0:0/power/state
> bash: echo: write error: Invalid argument
> # ll !$
> ll /sys/bus/scsi/devices/0:0:0:0/power/state
> -rw-r--r-- 1 root root 0 Aug  1 20:00 /sys/bus/scsi/devices/0:0:0:0/power/state
> # cat !$
> cat /sys/bus/scsi/devices/0:0:0:0/power/state
> 0
> # uname -a
> Linux bugs 2.6.18-rc3 #2 PREEMPT Sun Jul 30 16:26:22 CEST 2006 i686 GNU/Linux

You probably should do 'echo -n 1', the parsing function is pretty picky.

-- 
tejun
