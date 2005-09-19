Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVISGgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVISGgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVISGgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:36:48 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:58780 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750730AbVISGgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:36:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=CPcJ8oS3EwlOA9ESmgFMIKhLVyBJUjxRVjHWF0DfducF/GB7uHE75BtOk4C0MKPGzzVQof7INz/Qyv1gAn046woIve6/txAJ0PQb9lOxfxvYMo6Pl5f3pQStf0Rbn9fQ/fV4POj4IP5zJ/DCsU59RMS0QdtXtHCOaPAdbKNA4uE=  ;
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Shaohua Li <shaohua.li@intel.com>
Cc: vatsa@in.ibm.com, Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127111830.4087.3.camel@linux-hp.sh.intel.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 16:36:23 +1000
Message-Id: <1127111784.5272.10.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 14:37 +0800, Shaohua Li wrote:
> On Mon, 2005-09-19 at 11:53 +0530, Srivatsa Vaddagiri wrote:

> > default_idle should be fine as it is. IOW it should not cause __cpu_die to 
> > timeout.
> Why default_idle should be fine? it can be preempted before the
> 'local_irq_disable' check. Even with Nigel's patch, there is a very
> small window at safe_halt (after 'sti' but before 'hlt').
> 

Ah, actually I have a patch which makes all CPU idle threads
run with preempt disabled and only enable preempt when scheduling.
Would that help?

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
