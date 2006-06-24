Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWFXSBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWFXSBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWFXSBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:01:43 -0400
Received: from narn.hozed.org ([209.234.73.39]:42716 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S1751002AbWFXSBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:01:42 -0400
Date: Sat, 24 Jun 2006 13:01:41 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624180136.GO5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org> <1151151360.3181.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1151151360.3181.34.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 02:16:00PM +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-23 at 19:41 -0500, Troy Benjegerdes wrote:
> > This patch changes the in-kernel AFS client filesystem name to 'kafs',
> > as well as allowing the AFS cache manager port to be set as a module
> > parameter. This is usefull for having a system boot with the root
> > filesystem on afs with the kernel AFS client, while still having the
> > option of loading the OpenAFS kernel module for use as a read-write
> > filesystem later.
> 
> sounds weird... the filesystem it implements is afs.
> your change also breaks userspace, since the fs type is a mount option
> so your change is userspace visible and means people need to fix their
> scripts...
> 
> maybe openafs should start using "openafs" as type; they're not in the
> kernel so they aren't yet bound by the userspace ABI....

This is the most idiotic argument I have ever heard, and completely
ignores reality. The kernel module is named already named "kafs", not "afs"
and *NOBODY* is using it because it does not have authentication or
read-write support.

If you want to talk about breaking userspace and existing scripts, the
AFS filesystem (of which the OpenAFS code is derived from) has existed
and been in production far longer than Linux.

( see http://portal.acm.org/citation.cfm?doid=35037.35059 )

At Iowa State University alone there are around 20K people that depend
on OpenAFS running on Linux for webmail service.

The only scripts I could think of that would be impacted by changing the
kernel afs mount name to 'kafs' would be the ones I am writing, and anything
David Howells has. That amounts to *maybe* 10 users.

If you really care about breaking long-standing userspace ABI's, will
you accept a patch allowing kAFS, OpenAFS, and Arla to register to
recieve a callback when the AFS syscall number is called?

Now, if you could suggest another way to have both the *experimental* 
in-kernel AFS client and OpenAFS client with mounted filesystems, please
let me know.
