Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbSIRQYr>; Wed, 18 Sep 2002 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSIRQYr>; Wed, 18 Sep 2002 12:24:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:6126 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267253AbSIRQYq>;
	Wed, 18 Sep 2002 12:24:46 -0400
Message-ID: <3D88A9F5.F39ECD20@digeo.com>
Date: Wed, 18 Sep 2002 09:29:41 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
References: <3D815C8C.4050000@us.ibm.com> <1031922352.9056.14.camel@irongate.swansea.linux.org.uk> <20020913213042.GD3530@holomorphy.com> <200209181207.26655.frankeh@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 16:29:42.0011 (UTC) FILETIME=[973B4CB0:01C25F30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> Andrew, at the current time an mmap() ignores a MAP_LOCKED passed to it.
> The only way we can get VM_LOCKED associated with the newly created VMA
> is to have previously called mlockall() on the process which sets the
> mm->def_flags != VM_LOCKED or subsequently call mlock() on the
> newly created VMA.
> 
> The attached patch checks for MAP_LOCKED being passed and if so checks
> the capabilities of the process. Limit checks were already in place.

Looks sane, thanks.

It appears that MAP_LOCKED is a Linux-special, so presumably it
_used_ to work.  I wonder when it broke?

You patch applies to 2.4 as well; it would be useful to give that
a sanity test and send a copy to Marcelo.

(SuS really only anticipates that mmap needs to look at prior mlocks
in force against the address range.  It also says

     Process memory locking does apply to shared memory regions,

and we don't do that either.  I think we should; can't see why SuS
requires this.)
