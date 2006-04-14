Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWDNTC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWDNTC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDNTC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:02:59 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:9744 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751416AbWDNTC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:02:59 -0400
Message-ID: <443FF1D9.4060904@argo.co.il>
Date: Fri, 14 Apr 2006 22:02:49 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Dustin Kirkland <dustin.kirkland@us.ibm.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Kylene Jo Hall <kjhall@us.ibm.com>,
       kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
References: <1145027216.12054.164.camel@localhost.localdomain>	 <20060414170222.GA19172@thunk.org>  <443FE350.5040502@argo.co.il> <1145039347.3074.11.camel@localhost.localdomain>
In-Reply-To: <1145039347.3074.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2006 19:02:54.0593 (UTC) FILETIME=[0919FF10:01C65FF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dustin Kirkland wrote:
> On Fri, 2006-04-14 at 21:00 +0300, Avi Kivity wrote:
>   
>> How about using rsync with --delete as a substitute for cp (if rsync is 
>> available)?
>>     
>
> I thought about this, but a "grep -r rsync" didn't turn up any previous
> hits in the kernel build process.  I didn't want to introduce this as a
> new dependency for kernel building, if it's possible to avoid...
>   
Use rsync only if it is available:

    rsync-available := $(shell rsync --version > /dev/null 2>&1 && echo y)
    copy := $(if $(rsync-available), rsync --delete, cp)

    modules_install:
               [...]
               $(copy) source target

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

