Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUDIWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDIWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:17:29 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:15556 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261830AbUDIWRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:17:22 -0400
Date: Fri, 09 Apr 2004 15:01:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <2620000.1081548094@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0404092247480.5269-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404092247480.5269-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Hugh Dickins <hugh@veritas.com> wrote (on Friday, April 09, 2004 22:51:03 +0100):

> On Fri, 9 Apr 2004, Martin J. Bligh wrote:
>> > This anobjrmap 9 (or anon_mm9) patch adds Rajesh's radix priority search
>> > tree on top of Martin's 2.6.5-rc3-mjb2 tree, making a priority mjb tree!
>> > Approximately equivalent to Andrea's 2.6.5-aa1, but using anonmm instead
>> > of anon_vma, and of course each tree has its own additional features.
>> 
>> This slows down kernel compile a little, but worse, it slows down SDET
>> by about 25% (on the 16x). I think you did something horrible to sem
>> contention ... presumably i_shared_sem, which SDET was fighting with
>> as it was anyway ;-(
>> 
>> Diffprofile shows:
>> 
>>     122626    15.7% total
>>      44129   790.0% __down
>>      20988     4.1% default_idle
> 
> Many thanks for the good news, Martin ;)
> Looks like I've done something very stupid, perhaps a mismerge.
> Not found it yet, I'll carry on looking tomorrow.

I don't think so ... I ran across a similar problems when I tried to convert
the vma list to a list-of-lists for what you're trying to use prio_tree
for, I think. The sorry fact is that the that thing is heavily contended,
and doing complex manipulations under it makes it worse ;-(

I vaguely considered being a smarty-pants and doing RCU list-of-lists, but
never got around to it. I'll shove in some backtraces and check out the
sem activity to be sure.

M.

