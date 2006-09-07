Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWIGSFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWIGSFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWIGSFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:05:38 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:4257
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S1161025AbWIGSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:05:37 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: readdir race fix (take 3)
Date: Thu, 7 Sep 2006 20:07:24 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <200609071031.33855.jdelvare@suse.de> <m1wt8frd7j.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wt8frd7j.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609072007.25239.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 7 September 2006 15:57, Eric W. Biederman wrote:
> Jean Delvare <jdelvare@suse.de> writes:
> > I'll now apply Oleg's fix and see if things get better.

After 8 hours of stress testing on two machines, no crash and no freeze. 
So Oleg's fix seems to do the trick. Thanks Oleg :)

I'll keep the patches applied on both machines, even without stress tests 
it is still better to make sure nothing bad happens in the long run.

> > "My" test program forks 1000 children who sleep for 1 second then
> > look for themselves in /proc, warn if they can't find themselves, and
> > exit. So basically the idea is that the process list will shrink very
> > rapidly at the same moment every child does readdir(/proc).
> >
> > I attached the test program, I take no credit (nor shame) for it, it
> > was provided to me by IBM (possibly on behalf of one of their own
> > customers) as a way to demonstrate and reproduce the original
> > readdir(/proc) race bug.
>
> Ok.  So whatever is creating lots of child threads that tripped you
> up is probably peculiar to the environment on your laptop.

There's nothing really special running on this laptop. Slackware 10.2 with 
xterm, firefox, sylpheed, xchat, and that's about it. At least one of the 
crashes I had yesterday happened when I was actively using firefox, I 
can't tell for the other one.

The difference with the system where no problem was observed may be that 
the laptop has a preemptive kernel, and the desktop hasn't.

-- 
Jean Delvare
