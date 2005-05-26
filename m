Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVEZTfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVEZTfC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVEZTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:35:00 -0400
Received: from palrel13.hp.com ([156.153.255.238]:35472 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261714AbVEZTdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:33:02 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17046.9315.652129.602688@napali.hpl.hp.com>
Date: Thu, 26 May 2005 12:32:51 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, Shaohua Li <shaohua.li@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: Hotplug CPU printk issue
In-Reply-To: <20050525225204.68bf0684.akpm@osdl.org>
References: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	<1117076334.4086.11.camel@linux-hp.sh.intel.com>
	<20050525204828.70acc1b5.akpm@osdl.org>
	<1117086211.7657.10.camel@linux-hp.sh.intel.com>
	<20050525225204.68bf0684.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 May 2005 22:52:04 -0700, Andrew Morton <akpm@osdl.org> said:

  Andrew> Shaohua Li <shaohua.li@intel.com> wrote:

  >> > Please confirm that we in fact do not want to allow downed CPUs to
  >> > print things, then send a patch.
  >> Yep. In the cpu hotplug case, per-cpu data possibly isn't initialized
  >> even the system state is 'running'. As the comments say in the original
  >> code, some console drivers assume per-cpu resources have been allocated.
  >> radeon fb is one such driver, which uses kmalloc. After a CPU is down,
  >> the per-cpu data of slab is freed, so the system crashed when printing
  >> some info.

  Andrew> hm, that certainly sounds sane, but I do recall there were
  Andrew> reasonable-sounding reasons why the ia64 guys wanted
  Andrew> printk-on-a-down-CPU to work.  Hopefully David can remember
  Andrew> what the problem was so we can find a more thorough fix.

I don't recall having submitted such a patch.  According to the bk
log, it was Rusty who added the !system_running check (which was later
changed to system_state != SYSTEM_RUNNING).

The changelog only says:

 "- Allow printk on down cpus once system is running"

Rusty?

	--david
