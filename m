Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWIJR4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWIJR4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWIJR4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:56:49 -0400
Received: from tresys.irides.com ([216.250.243.126]:48293 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S932339AbWIJR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:56:48 -0400
Message-ID: <450451DB.5040104@gentoo.org>
Date: Sun, 10 Sep 2006 13:56:43 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
References: <20060910133759.GA12086@clipper.ens.fr>	 <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain>
In-Reply-To: <1157905393.23085.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0636-3, 09/08/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 10 Sep 2006 17:56:48.0166 (UTC) FILETIME=[7C7A0460:01C6D502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-09-10 am 15:42 +0200, ysgrifennodd David Madore:
>   
>> Introduce six new "regular" (=on-by-default) capabilities:
>>
>>  * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
>>    fork(), open() and exec() syscalls,
>>     
>
> CAP_REG_EXEC seems meaningless, I can do the same with mmap by hand for
> most types of binary execution except setuid (which is separate it
> seems)
>
> Given the capability model is accepted as inferior to things like
> SELinux policies why do we actually want to fix this anyway. It's
> unfortunate we can't discard the existing capabilities model (which has
> flaws) as well really.
>
>   
To expand on this a little, some of the capabilities you are looking to 
add are of very little if any use without being able to specify objects. 
For example, CAP_REG_OPEN is whether the process can open any file 
instead of specific ones. How many applications open no files whatsoever 
in practice? Even if there are some as soon as they change and need to 
open a file they'll need this capability and will be able to open any. 
CAP_REG_WRITE has the same problem. For a description of why 
CAP_REG_EXEC is meaningless see the digsig thread on the LSM list from 
earlier this year.

Further, adding more capabilities would likely make existing LSM's (like 
SELinux) deal with them. Since most LSM's already handle these 
permissions on a per-object basis these will be entirely redundant and 
more disruptive than useful.

Additionally since dropping capabilities is entirely discretionary and 
applications would be modified to actually drop the capabilities I can't 
ever see this being used in practice. It also embeds the policy into 
applications spread across the filesystem instead of having a 
centralized policy.  Since these are non-standard capabilities any 
application modified to take advantage of them could only do so on Linux.
