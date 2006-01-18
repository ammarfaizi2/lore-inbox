Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWARIBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWARIBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWARIBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:01:34 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:65202 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932404AbWARIBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:01:34 -0500
Message-ID: <43CE07C0.DA9B254A@tv-sign.ru>
Date: Wed, 18 Jan 2006 12:17:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru> <20060109205442.GB3691@localhost.localdomain> <43C40507.D1A85679@tv-sign.ru> <20060116205618.GA5313@localhost.localdomain> <43CD4C86.5B0BA4D0@tv-sign.ru> <20060117195237.GA5289@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> On Tue, Jan 17, 2006 at 10:59:02PM +0300, Oleg Nesterov wrote:
> >
> > But don't we already discussed this issue? I think that RUSAGE_SELF
> > case always not 100% accurate, so it is Ok to ignore this race.
> 
> Take the case when an exiting thread has a large utime stime value, and
> rusage reports utime before thread exit and stime after thread exit... the
> result would look wierd.
> So IMHO, while inaccuracies in task_struct->xxx time can be tolerated, it
> might not be such a good idea to for task_struct->signal->xxx counters.

Yes, you are right. Now I don't understand why I didn't understand this
before. Thank you, Ravikiran.

Oleg.
