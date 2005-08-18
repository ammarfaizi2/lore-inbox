Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVHRADN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVHRADN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVHRADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:03:13 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:16817 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751373AbVHRADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:03:12 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050817162324.GA24495@elte.hu>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 20:02:59 -0400
Message-Id: <1124323379.5186.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 18:23 +0200, Ingo Molnar wrote:
> > 
> > Using IPI Shortcut mode
> > khelper/794[CPU#0]: BUG in set_new_owner at kernel/rt.c:916
> 
> this is a 'must not happen'. Somehow lock->held list got non-empty.  
> Maybe some use-after-free thing? Havent seen it myself.

Well, I added all my patches and the laptop still locked up.

I then used my AMD SMP box config on my laptop and just changed the
processor, and it booted.  Not very well, since I didn't bother to
change any of the other configurations. But it didn't lock up.

So I went back to the laptop's original config, and did one change. I
disabled CONFIG_SCHED_SMT, rebooted, and the system booted up.  It
hasn't locked up after four boots.  It did once get into some crazy bug
with scheduling while atomic, but it just spit out so many of them that
I couldn't see what caused it. I'll turn back on netconsole to see if I
can capture that bug, but it seems to be related to someting different.

So I think something's wrong with the scheduling for hyper threading.

-- Steve


