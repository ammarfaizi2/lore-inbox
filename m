Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbSJCNcF>; Thu, 3 Oct 2002 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263302AbSJCNcE>; Thu, 3 Oct 2002 09:32:04 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:10924 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263301AbSJCNcB>; Thu, 3 Oct 2002 09:32:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: EVMS Submission for 2.5
Date: Thu, 3 Oct 2002 08:04:53 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210021848420.13480-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210021848420.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <02100308045305.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 18:02, Alexander Viro wrote:
> On Wed, 2 Oct 2002, Kevin Corry wrote:
> > So the question is, will there be a method to simply get a list of
> > registered disks on the system, or an API to call to run a function for
> > each disk? If so, we'll gladly switch to using that. If not, do you have
> > any suggestions for how this kind of functionality can be achieved with
> > your upcoming changes?
>
> That _really_ depends on the nature of functions you want to call that
> way.
>
> I might agree with something along the lines of
> 	* when evms is initialized, it's notified of all existing gendisks
> 	* whenever disk is added after evms initialization, we notify evms
> 	* whenever disk is removed, we notify evms

This sounds like it would be exactly what EVMS needs. The only thing we would 
want to add to this list is: "*whenever a disk is modified, notify evms". For 
example, with removable media drives (such as Zip and Jaz), when a cartidge 
is changed, the capacity of the drive might change, and we would like to be 
notified of that event.

> However, I doubt that it's what you really want.  In particular, you
> probably want to see partitioning changes as well as gendisk ones
> (and no, "evms will handle all partitioning" is _not_ an acceptable
> answer).

EVMS won't really be interested in partitioning changes. It only cares about 
whole devices, i.e. minor_shift == 0.

> Moreover, "gendisk is here" != "something is in the drive".

Will there be a common method for determining "media present"? The current 
method EVMS uses to determine "media changes" is somewhat inconsistent 
between IDE and SCSI.

> IOW, the real question is what are you going to do with that list of
> gendisks?

EVMS will try to read volume metadata from each device and activate volumes 
if it finds any pertinent metadata.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
