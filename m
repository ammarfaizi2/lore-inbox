Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVCWTur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVCWTur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVCWTur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:50:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58263 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262862AbVCWTuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:50:37 -0500
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: vivek goyal <vgoyal@in.ibm.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<1111552017.3604.78.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2005 12:47:14 -0700
In-Reply-To: <1111552017.3604.78.camel@localhost.localdomain>
Message-ID: <m1d5tqrvp9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:

> Hi all.
> 
> On Tue, 2005-03-08 at 18:20 +0530, vivek goyal wrote:
> > Core image ELF headers are prepared before crash and stored at a safe
> > place in memory. These headers are retrieved over a kexec boot and final
> > elf core image is prepared for analysis. 
> 
> Regarding the preparation of the ELF headers, I think we should also
> take into consideration hot-plug memory and create appropriate
> mechanisms to deal with it.
> 
> Assuming that both insertion and removal of memory trigger a hotplug
> event that is subsequently handled by the relevant hotplug agent(*), the
> latter could be modified so that, on successful memory onlining,
> additional PT_LOAD headers are created and tucked in a safe place
> together with the others.
> 
> Since ELF headers are to be prepared by kexec a new option could be
> added to it, so that we can call kexec from a hotplug script to carry
> out the aforementioned tasks.
> 
> Any thoughts or suggestions on this?

I like it.  This really shouldn't require anything new except 
a script to call /sbin/kexec.  

As long as memory hotplug is a rare event that should work
fine.  And with real hotplug it will be a rare event.  It looks
like something similar may also be needed for cpu hotplug, but
a compile time maximum on cpu may save us there.

The Xen guys idea of memory hotplug is another matter it sounds
like the want to page an OS with memory hotplug which is just
plain silly, and also unimplemented so I will cross that bridge
when I come to it.


Eric
