Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423682AbWJZVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682AbWJZVUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423684AbWJZVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 17:20:05 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:1299 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1423682AbWJZVUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 17:20:04 -0400
Message-ID: <4541267C.8040004@argo.co.il>
Date: Thu, 26 Oct 2006 23:19:56 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, lkml@pengaru.com,
       linux-kernel@vger.kernel.org
Subject: Re: rename() contention (BUG?)
References: <20061025205634.GB9100@shells.gnugeneration.com> <20061025211341.GB7128@filer.fsl.cs.sunysb.edu> <454101D6.9050004@argo.co.il> <20061026192219.GL29920@ftp.linux.org.uk>
In-Reply-To: <20061026192219.GL29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2006 21:20:03.0033 (UTC) FILETIME=[802F8C90:01C6F944]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Thu, Oct 26, 2006 at 08:43:34PM +0200, Avi Kivity wrote:
>   
>> The changes make the mutex more efficient, but won't decrease the 
>> contention.  It seems that all renames in one filesystem are serialized, 
>> and if the renames require I/O (which is certainly the case with nfs), 
>> rename throughput is severely limited.
>>     
>
> 	They are, and for a good reason.  For details see
> Documentation/filesystems/directory-locking.
>   

Is it possible to lock only the common subtree of the two paths?

Perhaps walk towards the root of the tree, starting with the deeper 
path, locking one component at a time.  Then walk both paths together 
locking components ordered by something to avoid deadlock.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

