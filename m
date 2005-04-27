Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVD0OYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVD0OYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVD0OYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261633AbVD0OXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:23:21 -0400
Date: Wed, 27 Apr 2005 22:26:38 +0800
From: David Teigland <teigland@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050427142638.GG16502@redhat.com>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427134142.GZ4431@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 03:41:42PM +0200, Lars Marowsky-Bree wrote:

> So in effect, the delivery of the suspend/membership distribution/resume
> events are three cluster-wide barriers?
> 
> I can see how that simplifies the recovery algorithm.

Correct.  I actually consider it two external barriers: the first after
the lockspace has been suspended, the second after lockspace recovery is
completed.

> And, I assume that the delivery of a "node down" membership event
> implies that said node also has been fenced.

Typically it does if you're combining the dlm with something that requires
fencing (like a file system).  Fencing isn't relevant to the dlm itself,
though, since the dlm software isn't touching any storage.

> So we can't deliver it raw membership events. Noted.

That's right, it requires more intelligence on the part of the external
management system in userspace.

> If you want to think about this in terms of locking hierarchy, it's the
> high-level feature rich sophisticated aka bloated lock manager which
> controls the "lower level" faster and more scalable "sublockspace" and
> coordinates it in terms of the other complex objects (like fencing,
> applications, filesystems etc).
> 
> Just some food for thought how this all fits together rather neatly.

Interesting, and sounds correct.  I must admit that using the word "lock"
to describe these CRM-level inter-dependent objects is new to me.

Dave

