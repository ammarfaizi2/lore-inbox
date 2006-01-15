Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWAOWXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWAOWXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWAOWXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:23:22 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:13755 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750935AbWAOWXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:23:22 -0500
Message-ID: <43CACB53.40205@cfl.rr.com>
Date: Sun, 15 Jan 2006 17:23:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Damian Pietras <daper@daper.net>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com> <20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com> <m3ek39z09f.fsf@telia.com>
In-Reply-To: <m3ek39z09f.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So mounting opens it in blocking  mode, causing it to lock, but pktcdvd 
does not open it in blocking mode, so it doesn't get locked until the 
mount?  Why does the cdrom driver differentiate between the two?  
Shouldn't it simply be locked when in use, no matter how it is used?  
And shouldn't pktcdvd explicitly unlock the drive when the pktcdvd 
device isn't open?  For that matter, why is mount opening the cdrom in 
blocking mode?  Shouldn't the filesystem be sending down async bios?

Peter Osterlund wrote:

>If you do
>
>	pktsetup 0 /dev/hdc
>	mount /dev/hdc /mnt/tmp
>	umount /mnt/tmp
>
>the door will be left in a locked state. (It gets unlocked when you
>run "pktsetup -d 0" though.) However, if you do:
>
>	pktsetup 0 /dev/hdc
>	mount /dev/pktcdvd/0 /mnt/tmp
>	umount /mnt/tmp
>
>the door will be properly unlocked.
>
>The problem is that the cdrom driver locks the door the first time the
>device is opened in blocking mode, but doesn't unlock it again until
>the open count goes down to zero. The pktcdvd driver tries to work
>around that, but it can't do it in the first example because the
>mount/umount commands do not involve the pktcdvd driver at all.
>
>  
>

