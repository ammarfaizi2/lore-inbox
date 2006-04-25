Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWDYSQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDYSQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWDYSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:16:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:21733 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932181AbWDYSQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:16:20 -0400
Date: Tue, 25 Apr 2006 11:11:58 -0700
From: Tony Jones <tonyj@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Andi Kleen <ak@suse.de>, jwcart2@epoch.ncsc.mil,
       Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060425181158.GB28479@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17485.55676.177514.848509@cse.unsw.edu.au> <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil> <200604251443.57885.ak@suse.de> <1145977265.21399.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145977265.21399.16.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 11:01:05AM -0400, Stephen Smalley wrote:
> AppArmor doesn't control IPC (which has been noted previously), and it
> isn't clear how one generalizes its path-based scheme to handle all
> kinds of kernel operations.  

Maybe it will have to grow to handle more operations.  SELinux has grown in
terms of it's features and what it protects.  Clearly you have benefitted
from being open sourced for an extended period of time.  I'm sure you'd love
to debate the history of this :) but there doesn't seem much productive point.

But I agree, it isn't clear how the AA scheme applies to all forms of kernel
operations.

> mechanism.  Which brings up an interesting topic of its own:  If you
> want the AppArmor model, then why not just use existing jail-like or
> virtualization mechanisms?  IIUC, Vservers and OpenVZ are already far

Because it presumes that the application can easily be configured to function
in a jail.

> more complete in their coverage than AppArmor and leverage existing
> kernel mechanisms like namespaces that at least have well-defined
> semantics.  I expect that I could achieve a much higher degree of
> confidence in such a mechanism than in AppArmor.  Why can't AppArmor
> just become a userspace tool for configuring namespaces and setting up
> the environment in which the application runs?

How do you propose handling in a namespace the ability to create new files.
I can see how you could perhaps create a fixed scratch area inside the 
namespace, but what if the application wants to create /var/lib/foo/bar.xxx

You have obviously read the AppArmor docs. How would you propose to handle 
(approximately) the expressiveness of AppArmor policy. Also what does 
/srv/www/htdocs/**.html equate to when this namespace is configured for the 
application. Does the task need to be torn down and restarted if you populate 
more files?

The issue of namespaces being a better way of doing all of this has been raised
a couple of times.  It is an interesting idea for sure. I responded to one of
the posts with the same (above) questions but havn't yet seen a reply.

Other LSM hooks are an option also.  Clearly if we can add new hooks at more
optimal locations where pathnames are available it would be preferable to
the current scheme and (qualifier: the devil is in the details) probably 
preferable to trying to pass vfsmounts fully into the existing hooks.

Tony
