Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUG2PFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUG2PFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUG2PDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:03:54 -0400
Received: from jade.spiritone.com ([216.99.193.136]:60098 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S265230AbUG2OT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:19:57 -0400
Date: Thu, 29 Jul 2004 07:18:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
cc: suparna@in.ibm.com, fastboot@osdl.org, jbarnes@engr.sgi.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <138620000.1091110702@[10.10.2.4]>
In-Reply-To: <m1u0vr4luo.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au><20040725235705.57b804cc.akpm@osdl.org><m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com><200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay><m14qnr7u7b.fsf@ebiederm.dsl.xmission.com><20040728133337.06eb0fca.akpm@osdl.org><1091044742.31698.3.camel@localhost.localdomain><m1llh367s4.fsf@ebiederm.dsl.xmission.com><20040728164457.732c2f1d.akpm@osdl.org><m1d62f6351.fsf@ebiederm.dsl.xmission.com><20040728180954.1f2baed9.akpm@osdl.org> <m1u0vr4luo.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well if calling shutdown is not really usable, then I we had better
> transition quickly beyond using it...
>  
>> [*] At least, I _assume_ the 16MB will be prereserved,
>>     physically-contiguous and wholly within ZONE_NORMAL.  Is this wrong?
> 
> The problem is that we really won't be using it for running code out
> of because of i386 kernel limitations.  Unless someone can tell
> my why 0 -16MB won't have DMA traffic in them.  Or how to run a kernel
> at an address other than 1MB.
> 
> I suspect we can play with the initial page tables and how virtual
> addresses map to physical addresses and fairly simply generate a
> relocatable kernel.  I have not had a chance to investigate that
> though.  Once we have that it will be trivial to run out of the
> reserved 16M and many of the practical problems melt away.

IIRC, what Adam did is to relocate the bottom 16MB of mem into the
reserved buffer and execute into the bottom 16MB. Yes, that probably does
leave some DMA issues that we should fix up as you suggest above, but I
think it's good enough for a first pass at the problem.

M.

