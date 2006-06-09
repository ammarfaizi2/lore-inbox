Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWFIXrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWFIXrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWFIXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:47:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9394 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932596AbWFIXrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:47:35 -0400
Message-ID: <448A089C.6020408@engr.sgi.com>
Date: Fri, 09 Jun 2006 16:47:40 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nagar@watson.ibm.com, balbir@in.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<4489F93E.6070509@engr.sgi.com> <20060609162232.2f2479c5.akpm@osdl.org>
In-Reply-To: <20060609162232.2f2479c5.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Jay Lan <jlan@engr.sgi.com> wrote:
>  
>>If you can show me how to not sending per-tgid with current patchset,
>>i would be very happy to drop this request.
>>    
>
>pleeeze, not a global sysctl.  It should be some per-client subscription thing.
>  

Per-client subscription is not possible since it is the push (multicast)
model we
talk about and delayacct needs tgid.

>But the overhead at present is awfully low.  If we don't need this ability
>at present (and I don't think we do) then a paper design would be
>sufficient at this time.  As long as we know we can do this in the future
>without breaking existing APIs then OK.
>  
i can see if an exiting process is the only process in the thread group,
the (not is_thread_group) condition would be true. So, that leaves
multi-threaded applications that are not interested in tgid-data still
receive 2x taskstats data.

Is a system-wide switch that bad? A site  that needs tgid stats can live
with the performance consequence while those do not need tgid can
enjoy a pure per-task stats data. (I would argue that a thread group
is some sort of task aggregate.)

How about sending tgid stats when the last process in the group exist?
But do not send it if not the last in the thread?

Thanks,
 - jay

