Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSKMBL3>; Tue, 12 Nov 2002 20:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbSKMBL3>; Tue, 12 Nov 2002 20:11:29 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:6129 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S267079AbSKMBL2>; Tue, 12 Nov 2002 20:11:28 -0500
Message-ID: <3DD1A899.8080800@mvista.com>
Date: Tue, 12 Nov 2002 18:19:21 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Jackson <brian-kernel-list@mdrx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian,

The RAID driver does indeed work with shared storage, if you don't have 
RAID autostart set as the partition type.  If you do, each host will try 
to rebuild the RAID array resulting in really bad magic.

I posted patches to solve this problem long ago to this list and 
linux-raid, but Neil Brown (md maintainer) rejected them saying that 
access to a raid volume should be controlled by user space, not by the 
kernel.  Everyone is entitled to their opinions I guess. :)

The patch worked by locking RAID volumes to either a FibreChannel host 
WWN (qlogic only) or scsi host id.  This ensured that if a raid volume 
was started, it could ONLY be started on the host that created it.  This 
worked for the autostart path as well as the start path via IOCTL.

I also modified mdadm to handle takeover for failed nodes to takeover 
RAID arrays.

I'm extending this type of support into LVM volume groups as we speak. 
 If you would like to see the patch when I'm done mail me and I'll send 
it out.  This only applies to 2.4.19.

Thanks
-steve

Brian Jackson wrote:

> Here's a question for all those out there that are smarter than me(so 
> I guess that's most of you then :) I looked around (google, kernel 
> source, etc.) trying to find the answer, but came up with nothing.
> Does the MD driver work with shared storage? I would also be 
> interested to know if the new DM driver works with shared 
> storage(though I must admit I didn't really try to answer this one 
> myself, just hoping somebody will know).
> I ask because I seem to be having some strange problems with an md 
> device on shared storage(Qlogic FC controllers). The qlogic drivers 
> spit out messages for about 20-60 lines then the machines lock up. So 
> the drivers were my first suspicion, but they were working okay 
> before. So I went back and got rid of the md device and now everything 
> is working again. Anybody got any ideas?
> My logic says that it should work fine with shared storage, but my 
> recent experience says my logic is wrong.
> --Brian Jackson
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

