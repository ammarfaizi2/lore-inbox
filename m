Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUA1Drc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUA1Drb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:47:31 -0500
Received: from agminet03.oracle.com ([141.146.126.230]:15555 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S265839AbUA1Dra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:47:30 -0500
Message-ID: <40172F30.8050602@oracle.com>
Date: Wed, 28 Jan 2004 04:40:32 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@redhat.com>
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
References: <40171B5B.4020601@oracle.com> <Pine.LNX.4.58.0401271859140.10794@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401271859140.10794@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 28 Jan 2004, Alessandro Suardi wrote:
> 
>>Already reported, but I'll do so once again, since it looks like
>>  in a short while I won't be able to boot official kernels in my
>>  current config...
>>
>>	http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0442.html
> 
> 
> Can you make adjust_jiffies() print out its arguments (it's in 
> drivers/cpufreq/cpufreq.c).
> 
> It looks like cpufreq_scale() gets a divide-by-zero or an overflow on one 
> of
> 
> 	l_p_j_ref, l_p_j_ref_freq, ci->new
> 
> and just printing out those values would be interesting.

Assuming the late hour (hmm, early by now) hasn't crossed my
  eyes entirely the three above entities are %lu, %u, %u... so
  this line

printk("CPUFREQ DEBUG: [%lu] [%u] [%u]\n", l_p_j_ref, l_p_j_ref_freq, ci->new);

  as both first and last instruction in adjust_jiffies() turns
  up the same values, which are 1773568, 1, 0.


Side-note, since master penguin is looking... after the oops
  all SysRq stuff keeps working - except Alt-SysRq-B; the atkbd.c
  code tells me the keyboard says "too many keys pressed". K, T,
  P just do their job fine.
(yeah, okay, Alt-SysRq-O prints Power Off but obviously doesn't).


Thanks,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

