Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030767AbWKORwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbWKORwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030772AbWKORwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:52:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27022 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030767AbWKORwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:52:05 -0500
Message-ID: <455B53C7.1060604@mentalrootkit.com>
Date: Wed, 15 Nov 2006 12:52:07 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
References: <XMMS.LNX.4.64.0611151115360.8593@d.namei>  <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> <26860.1163607813@redhat.com>
In-Reply-To: <26860.1163607813@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> James Morris <jmorris@namei.org> wrote:
> 
>> Well, the value can be changed at any time, so you could be using a 
>> temporary fscreate value, or your new value could be overwritten 
>> immediately by writing to /proc/$$/attr/fscreate
> 
> Ah.  Hmmm.  By whom?  In selinux_setprocattr():
> 
> 	if (current != p) {
> 		/* SELinux only allows a process to change its own
> 		   security attributes. */
> 		return -EACCES;
> 	}
> 
> But current busy inside the cache and can't do this.
> 
>> I think we need to add a separate field for this purpose, which can only 
>> be written to via the in-kernel API and overrides fscreate.
> 
> So, like my acts-as security ID patch?
> 
> Would it still need to be controlled by MAC policy in that case?

Yes - if we are going to perform some MAC checks for this kernel process 
we need to have all checks performed.

   Doing so is
> a bit of a pain as it means I have a whole bunch of extra failures I still
> need to check for,

This is true for going this route in general rather than simply 
bypassing MAC. I don't think halfway makes any sense.

  and the race in which the rules might change is still a
> possibility I have to deal with.
> 

I don't think this is a race, it is revocation of access. If you check 
the access at every operation and correctly deal with access failures, 
then this shouldn't be a problem. Yes it is a pain, but that is how 
SELinux is supposed to work.

Karl

