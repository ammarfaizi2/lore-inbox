Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWDNSA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWDNSA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWDNSA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:00:56 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:2319 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751343AbWDNSAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:00:55 -0400
Message-ID: <443FE350.5040502@argo.co.il>
Date: Fri, 14 Apr 2006 21:00:48 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>, Kylene Jo Hall <kjhall@us.ibm.com>,
       kbuild-devel@lists.sourceforge.net, dustin.kirkland@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
References: <1145027216.12054.164.camel@localhost.localdomain> <20060414170222.GA19172@thunk.org>
In-Reply-To: <20060414170222.GA19172@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2006 18:00:53.0561 (UTC) FILETIME=[5F319290:01C65FED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Fri, Apr 14, 2006 at 10:06:56AM -0500, Kylene Jo Hall wrote:
>   
>> This new "modules_update" target only copies out modules that have
>> changed, using "cp -u".  This less zealous method is a more efficient
>> approach to module installation for kernel developers working on single,
>> or small numbers of modules.  
>>     
>
> Hi Kylene,
>
> This works as long as the .config hasn't been changed so that some
> configuration options haven't been changed so that a driver which had
> been previously built as a module is now built into the kernel.  In
> that case, you really want to make sure the no-longer applicable .ko
> file has been removed from the system.  If the developer knows that to
> be true, they can use your proposed modules_update without any problems.
>
> As a suggestion, something that might be worth trying would be to
> change to modules_install so that it uses cp -u, but also so that it
> tries to delete all files that could have previously installed as
> modules (by using the obj-y list).  This should hopefully speed up
> modules_install, and make it do the right thing all the time.
>
>   
How about using rsync with --delete as a substitute for cp (if rsync is 
available)?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

