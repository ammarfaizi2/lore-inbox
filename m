Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbTCaO3c>; Mon, 31 Mar 2003 09:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbTCaO3c>; Mon, 31 Mar 2003 09:29:32 -0500
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:54915 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP
	id <S261654AbTCaO3b>; Mon, 31 Mar 2003 09:29:31 -0500
Date: Mon, 31 Mar 2003 07:40:42 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem created by Zoning on Linux
In-Reply-To: <000001c2f780$da0265e0$e9bba5cc@patni.com>
Message-ID: <Pine.LNX.4.44.0303310737290.26215-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, chandrasekhar.nagaraj wrote:

> Hi,
> We are trying to create zoning (IO fencing) on our storage device.
> The zoning is to be done on the LUN basis, so that a particular HBA will
> accesses the only those LUNs which are assigned to it.
> 
> We have two HBA cards residing on different Hosts.

Hi,
We've used Linux to access our cx600 and there were no problems.  One thing
to keep in mind is that you are only allowed to have a single initiator per
zone, otherwise you will run into problems.  When you create your zones make
sure that each zone only has a single HBA in it...  

Also, on your switch, look at the error counters.  If there are any 
number of CRC errors it may mean a bad cable.

What is the FC card and driver you are currently using?

Regards
James Bourne

> 
> We have created 8 LUNs (from 0 to 7).
> Now we want to give access to only 4 LUNs from each HBA card.
> 
> So we have given access to LUN 0 to 3 from HBA card 1.
> Also LUN 4 to 7 is to be accessed from HBA card 2.
> 
> When we did the above, we observed that the Host, which has access to LUN 0
> to 3, is working fine. i.e. its /proc/scsi/scsi is showing entries
> corresponding to LUN 0 to 3. Also 4 scsi devices are created & can be viewed
> in /proc/partitions.
> 
> But the second Host, which should have access to LUN 4 to 7, has some
> problem.
> The /proc/partitions does not show any scsi device file. Also
> /proc/scsi/scsi does not entries corresponding to LUN 4 to 7; but it have
> only one entry corresponding to LUN 0 (which should not be allowed).
> 
> So, is there any restriction on Linux that the LUN number should start with
> 0 only??
> If so, then what is the solution/workaround?
> 
> Thanks and Regards
> Chandrasekhar
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

