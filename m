Return-Path: <linux-kernel-owner+w=401wt.eu-S1751531AbXAPRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXAPRPb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbXAPRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:15:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:44625 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbXAPRP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:15:29 -0500
Message-ID: <45AD02FF.605@zytor.com>
Date: Tue, 16 Jan 2007 08:53:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>, netdev@vger.kernel.org,
       xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com, minyard@acm.org,
       openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
       linux-mips@linux-mips.org, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de, vojtech@suse.cz,
       clemens@ladisch.de, a.zummo@towertech.it, rtc-linux@googlegroups.com,
       linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
       philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> - Removal of sys_sysctl support where people had used conflicting sysctl
>   numbers. Trying to break glibc or other applications by changing the
>   ABI is not cool.  9 instances of this in the kernel seems a little
>   extreme.
> 

It would be highly advantageous if we could have a file that acts as a 
central registry of architectural sysctl numbers *and have the numbers 
in the kernel derived from there*.  As I've said before, I don't really 
think sys_sysctl is any worse than ad hoc system calls (sys_mips and the 
like), but the real problem is that there are architectural and 
non-archtectural numbers, and they're mixed in all over the place.

I think it would be fair to say that if they're not in <linux/sysctl.h> 
they're not architectural, but that doesn't resolve the counterpositive 
(are there sysctls in <linux/sysctl.h> which aren't architectural?  From 
the looks of it, I would say yes.)  Non-architectural sysctl numbers 
should not be exported to userspace, and should eventually be rejected 
by sys_sysctl.

	-hpa
