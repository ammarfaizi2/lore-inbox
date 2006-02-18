Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWBRBU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWBRBU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWBRBU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:20:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751816AbWBRBU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:20:26 -0500
Message-ID: <43F6769C.5010505@ce.jp.nec.com>
Date: Fri, 17 Feb 2006 20:21:32 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md)
References: <43F60F31.1030507@ce.jp.nec.com> <20060217194249.GO12169@agk.surrey.redhat.com>
In-Reply-To: <20060217194249.GO12169@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alasdair G Kergon wrote:
> I can't speak for the 'mount' code base, but I don't think it'll
> make any significant difference to LVM2 - we'd still have to do 
> all the same device scanning as we do now because we have to be
> aware of md devices defined in on-disk metadata regardless of 
> whether or not the kernel knows about them at the time the 
> command is run.

Actually, as you say, LVM2 already does the relationship analysis
correctly by itself. So it's not 'good' example...
The point was that dm and md have similar dependency
structure but currently we have to scan all devices to
find out the upward relationship using different method
for dm and md.

>>thus we only need to check "holders" directory of the device
>>to decide whether the device is used by dm/md.
>>Also we can walk down the "slaves" directories to collect
>>the devices conposing the given dm/md device.
> 
> For device-mapper devices, 'dmsetup deps' and ls --tree already
> gives you this information reasonably efficiently.

Speaking about the efficiency, 'dmsetup ls --tree' works well.
However, I haven't yet found a efficient way to implement
'dmsetup info --tree -o inverted dm-0', for example.

Deps ioctl provides downward information for a given dm device
but there is no method for upward information.

Providing reverse-deps ioctl in dm may be alternative solution.
But it still doesn't provide the holders of non-dm devices.
So I feel sysfs solution is appealing.

> Would others find the proposal useful for non-dm devices?

I would appreciate comments from others as well.

> And rather than adding code just to dm and md, would it be better 
> to implement it by enhancing bd_claim()?

It may be possible if I can extend the bd_claim to accept
additional parameter because all dm devices use same 'holder'
signature for bd_claim but actual owner of the claim should
be determined to create symlinks.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
