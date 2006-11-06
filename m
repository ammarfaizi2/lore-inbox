Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423510AbWKFFJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423510AbWKFFJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 00:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423513AbWKFFJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 00:09:09 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:35975 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423510AbWKFFJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 00:09:07 -0500
Message-ID: <454EC32F.2010004@in.ibm.com>
Date: Mon, 06 Nov 2006 10:37:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, jlan@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       winget@google.com, rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] [PATCH 6/6] Resource Groups over generic containers
References: <20061004234316.677837000@menage.corp.google.com>	<20061004235752.935272000@menage.corp.google.com>	<454E5437.1020909@in.ibm.com> <20061105133421.6cea9734.pj@sgi.com>
In-Reply-To: <20061105133421.6cea9734.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Balbir wrote:
>> This should be kmalloc(nbytes), an echo ".." has a "\n" associated
>> with it.
> 
> But a:
>   write(1, "..", 2);
> does not have a trialing newline.

Yes, true.

> 
> If some consumer of this kernel buffer copy of what the
> user wrote cannot handle the possible trailing whitespace,
> they will have to chomp (Perl phrase) it off.  You can't
> just whack one byte blindly.
> 

Yes, agreed.

> At least for the kernel/cpuset.c code, from whence this
> came, the consumers of this kernel buffer copy are such
> routines as simple_strtoul() and cpulist_parse(), both
> of which cope with trailing newlines.
> 

The problem I have is that match_token() that's used by
the resource group's infrastructure cannot deal with
"\n". I think the code needs in res_groups needs to
get smarter like the code in simple_strtoul()


-- 
	Thanks for the feedback,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
