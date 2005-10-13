Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVJMAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVJMAVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVJMAVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:21:43 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:31111 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964827AbVJMAVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:21:42 -0400
Date: Thu, 13 Oct 2005 02:21:41 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051013000921.GD23770@mail.shareable.org>
Message-ID: <Pine.LNX.4.62.0510130217050.15206@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
 <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
 <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
 <20051013000921.GD23770@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Oct 2005, Jamie Lokier wrote:

> Mikulas Patocka wrote:
>> But discarding data sometimes on USB unplug is even worse than discarding
>> data always --- users will by experimenting learn that linux doesn't
>> discard write-cached data and reminds them to replug the device --- and
>> one day, randomly, they lose their data because of some memory management
>> condition...
>
> It should not happen provided the total amount of dirty data for
> detachable devices is restricted to allow enough room for opening a
> dialog.

That is possible ... you must also make sure that you do not hold an 
important semaphore while waiting for some removable device (auditing VFS 
for this will be a bit harder...)

Mikulas

> That's no different, in principle, than the restrictions that are used
> to ensure some types of kernel memory allocation always succeed.
>
> There's no exact calculation, just a notion of "this many megabytes
> should be enough for a dialog".
>
> -- Jamie
>
