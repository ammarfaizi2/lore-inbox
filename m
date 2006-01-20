Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWATRE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWATRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWATRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:04:27 -0500
Received: from free.wgops.com ([69.51.116.66]:25348 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751103AbWATRE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:04:27 -0500
Date: Fri, 20 Jan 2006 10:04:19 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <67530D832C57FA520C952690@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120163433.GB5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <20060120163433.GB5873@stiffy.osknowledge.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 5:34:33 PM +0100 Marc Koschewski 
<marc@osknowledge.org> wrote:

> I know. But you we're the one who started this off. The 'beast' should be
> maintained by people that need it. And it was just a brainstorm, moreover.

Understood.  However these sorts of changes are still more appropriate in a 
development kernel/tree, not in what's generally supposed to be accepted as 
a stable code base.

>> Lots of things still out there depend on devfs.  So now if I want to
>> develop my kmod on recent kernels I have to be in the business of
>> maintaining a lot more userland stuff, like mkinitrd, installers, etc.
>> that  have come to rely on devfs.
>
> What exactly relies on _devfs_?

devfs=mount/nomount for one in kernel params, mount commands for another 
(mount -t devfs ....), modprobe devfs, these are at the lowest level. 
Scripts are written, as are bits of code, with the assumption that they'll 
get their /dev tree/dependency satisfied in a certain way.

>
>>
>> The point is this is happening in what is being called a stable kernel.
>> Stable it isn't.  The whole devfs thing is likely to cause me a lot of
>> work, I'd stay with 2.4 in the worst affected things, but I can't.
>> devfs  is newish for and already been deprecated and killed before a
>> major release  even, that just seems not right.
>
> As far as I remember the devfs maintainer didn't do just a one-liner of
> changes plus he was not to be reached by mail. No reply, no list
> acitivity, ... nothing. Just out of the town.
>
>>
>> Anyway hopefully this thread wills tart some constructive thought on
>> this  rather than being pointless, but I had to get it out there.  I
>> know I have  a habit of showing up every other year or so. :)
>
> This thread will start something, yes. But I don't think we will have a
> decision in the end. The kernel grows. In size, in features, in just
> about anything. And from a developers point of view it's always wise to
> re-write a subsystem with a new API and the freedom to do _whatever_ one
> thinks she could do than re-write a subsystem due to maintaining the
> interface for compatibility.

Which is fine in a development tree.  The problem here is making these 
changes, blowing away APIs, especially userland ones, in a stable tree. 
For various reasons embedded systems will often need to stay current with 
the 'stable' kernel.  You try developing modules against a 'stable' kernel 
for embedded purposes when things are changing under you.  Yes that's a 
partially commercial argument, but it's also a general argument.  The even 
numbered releases are/were supposed to be atleast mostly stable.  And in my 
mind atleast that means that APIs don't come and go on a whim.

> The two cases exactly are:
>
> 	* _new_ code with all new features planned
>
> 	or
>
> 	* _partly new_ code with some new features due to API incompatibility a
> la 	  'what we have to do is to get the best we can from what we have'
>
> And the latter is definitely the wrong way to go. Just my 2 cents...

Which is why everyone else seperates development from maintenance.  AIX, 
HP-UX, even Windows does (ok...so maybe not Windows).

The problem is these sorts of changes are 'normally' reserved for 
development trees because they can break (and will) break things and they 
obviously change things.

What do you think would happen if OpenSSL changed it's API incompatibly in 
say (arbitrarily) six months for a point release doing away with something 
in a stable release?

I guess I'm just the net.kook and the only one spending time and effort to 
clean up a mess created simply because he needed to go up a point rev, and 
atleast one otherwise working feature.

No devfs was not, is not perfect, and I agree something better was needed, 
but in a stable kernel?  I'm arguing against userland API changes 
specifically in stable kernels, and in a more broad sense even internal API 
changes in a stable kernel, atleast where they most certainly affect 
development of code, or maintenance releases of code requiring upgrades of 
the kernel in general.

If 2.6 were stable I should be able to write a module for the '2.6' API, 
like PHP, like Apache, like Zend, like OpenSSL, and be reasonably certain 
that atleast the API wasn't going to drastically change or go away when I 
rebuild the binaries for a security update or 'minor' update of say needing 
support for the new PCI IDs of the latest e1000 variants.
