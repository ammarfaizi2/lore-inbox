Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWHQBoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWHQBoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHQBoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:44:07 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:52619 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932370AbWHQBoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:44:03 -0400
Subject: Re: peculiar suspend/resume bug.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816024140.GA30814@srcf.ucam.org>
References: <20060815221035.GX7612@redhat.com>
	 <1155687599.3193.12.camel@nigel.suspend2.net>
	 <20060816003728.GA3605@redhat.com>  <20060816024140.GA30814@srcf.ucam.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 11:44:30 +1000
Message-Id: <1155779070.3369.44.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-08-16 at 03:41 +0100, Matthew Garrett wrote:
> On Tue, Aug 15, 2006 at 08:37:28PM -0400, Dave Jones wrote:
> 
> > cpufreq-applet crashes as soon as the cpu goes offline.
> > Now, the applet should be written to deal with this scenario more
> > gracefully, but I'm questioning whether or not userspace should
> > *see* the unplug/replug that suspend does at all.
> 
> As Nigel mentioned, cpu unplug happens just before processes are frozen, 
> so I guess there's a chance for it to be scheduled. On the other hand, 
> it's not unreasonable for CPUs to be unplugged during runtime anyway - 
> perhaps userspace should be able to deal with that?

Agreed.

I've spent a little more time thinking about this, and want to put a few
thoughts forward for discussion/ignoring/flame bait/whatever.

I see two main issues at the moment with freezing before hotplugging.
The first is that we have cpu specific kernel threads that we're going
to want to kill, and the second is that we have userspace threads that
we want to migrate to another cpu. Have I missed anything?

The first issue could be helped by splitting the freezing of userspace
processes from kernel space. The kernel threads could thus die without
us having to worry about userspace seeing what's going on. I haven't
looked at vanilla in a while; this might already be in. Alternatively,
if it's viable, per-cpu kernel threads could perhaps be made NO_FREEZE.

The second issue is migrating userspace threads. I'm no scheduling
expert, so I'll just speculate :>. I wondered if it's possible to make
the migration happen lazily; in such a way that if, when we come to thaw
userspace, the cpu has been hotplugged again, the migration never
happens. Does that sound possible?

Regards,

Nigel

