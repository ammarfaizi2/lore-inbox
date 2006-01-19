Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWASWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWASWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWASWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:17:57 -0500
Received: from host233.omnispring.com ([69.44.168.233]:60168 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1422668AbWASWR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:17:56 -0500
Message-ID: <43D00FFA.1040401@cfl.rr.com>
Date: Thu, 19 Jan 2006 17:17:30 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au>
In-Reply-To: <17358.52476.290687.858954@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2006 22:18:47.0925 (UTC) FILETIME=[51856250:01C61D46]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14216.000
X-TM-AS-Result: No--11.200000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently of the opinion that dm needs a raid5 and raid6 module 
added, then the user land lvm tools fixed to use them, and then you 
could use dm instead of md.  The benefit being that dm pushes things 
like volume autodetection and management out of the kernel to user space 
where it belongs.  But that's just my opinion...


I'm using dm at home because I have a sata hardware fakeraid raid-0 
between two WD 10,000 rpm raptors, and the dmraid utility correctly 
recognizes that and configures device mapper to use it. 


Neil Brown wrote:
> Which bits?
> Why?
>
> My current opinion is that you should:
>
>  Use md for raid1, raid5, raid6 - anything with redundancy.
>  Use dm for multipath, crypto, linear, LVM, snapshot
>  Use either for raid0 (I don't think dm has particular advantages
>      for md or md over dm).
>
> These can be mixed together quite effectively:
>   You can have dm/lvm over md/raid1 over dm/multipath
> with no problems.
>
> If there is functionality missing from any of these recommended
> components, then make a noise about it, preferably but not necessarily
> with code, and it will quite possibly be fixed.
