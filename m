Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbULASxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbULASxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 13:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbULASxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 13:53:45 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:59698 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261410AbULASwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 13:52:25 -0500
X-IronPort-AV: i="3.87,119,1099263600"; 
   d="scan'208"; a="81909:sNHT24059264"
Message-ID: <41AE12E4.9080609@fujitsu-siemens.com>
Date: Wed, 01 Dec 2004 19:52:20 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: user-mode-linux-devel@lists.sourceforge.net,
       BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host
 bug?
References: <200411292315.25368.blaisorblade_spam@yahoo.it> <200411301950.13529.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411301950.13529.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Monday 29 November 2004 23:15, Blaisorblade wrote:
> 
> However, I've now discovered that it only happens when CONFIG_STATIC_LINK is 
> enabled - that makes the kernel die. The interesting thing is that it becomes 
> unkillable
Have found the reason for the task to become unkillable, i.e. state 'D'.

There is a bug in 2.6.9 and up in fs/exec.c

If the kernel does coredump_wait(), it tries to kill all other threads, that are
running on the same mm. Therefore it calls "force_sig_specific(SIGKILL, p)".
But if one of the threads is on a ptrace-stop, SIGKILL has no effect.
The killing thread will wait forever in "D".

Bodo
