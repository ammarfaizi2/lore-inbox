Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbTAJBks>; Thu, 9 Jan 2003 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTAJBks>; Thu, 9 Jan 2003 20:40:48 -0500
Received: from fmr02.intel.com ([192.55.52.25]:18924 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268096AbTAJBkr> convert rfc822-to-8bit; Thu, 9 Jan 2003 20:40:47 -0500
content-class: urn:content-classes:message
Subject: RE: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 15:26:38 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E206@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: detecting hyperthreading in linux 2.4.19
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK4GtMklk+4myQMEde/HABQi2jWFgAGq1zA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jason Lunz" <lunz@falooley.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2003 23:26:39.0454 (UTC) FILETIME=[8F77E7E0:01C2B836]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Systems running the latest RH, SuSE releases, with standard smp kernel
should see some entries in /proc/cpuinfo, which gives information about
HT configuration on the system. The latest 2.5 kernel also has similar
information in /proc/cpuinfo.
The entries look something like:
Physical processor ID   : 0
Number of siblings      : 2

Unfortunately, 2.4.19 doesn't have such information. One possible
workaround is to check big enough 'dmesg' and look for cpu_sibling_map.
That tells you the mapping of logical processors to physical package. Or
you can have a init script like this (attached) in place, to run at boot
time, so that you have a better chance of finding these particular
messages in log (without overflowing).

HTH,
Venkatesh

-------------------
#!/bin/sh
# checkht kernel RC file.
#
# chkconfig: 35 98 98
# description: check for hyperthreaded CPUs

HASHT=`/bin/dmesg | /bin/grep cpu_sibling_map`

if [ -n "$HASHT" ]; then
        /bin/echo "Machine is running HT"
        /bin/echo 1 > /etc/hyperthreaded
else
        /bin/echo "Machine isn't running HT"
        /bin/echo 0 > /etc/hyperthreaded
Fi
--------------


> -----Original Message-----
> From: Jason Lunz [mailto:lunz@falooley.org] 
> Sent: Thursday, January 09, 2003 12:03 PM
> To: linux-kernel@vger.kernel.org
> Subject: detecting hyperthreading in linux 2.4.19
> 
> 
> Is there a way for a userspace program running on linux 2.4.19 to tell
> the difference between a single hyperthreaded xeon P4 with HT enabled
> and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
> for the two cases are indistinguishable.
> 
> Jason
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
