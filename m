Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWDZXlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWDZXlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWDZXlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:41:44 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:9127 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1751220AbWDZXlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:41:44 -0400
Subject: Re: [dm-devel] [RFC] dm-userspace
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: Dan Smith <danms@us.ibm.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87psj45420.fsf@caffeine.beaverton.ibm.com>
References: <87u08g553l.fsf@caffeine.beaverton.ibm.com>
	 <1146092129.14129.333.camel@localhost.localdomain>
	 <87psj45420.fsf@caffeine.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 19:41:17 -0400
Message-Id: <1146094877.14129.343.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2006-04-26 at 16:07 -0700, Dan Smith wrote:
> MZ> just curious, will the speed be a problem here? 
> 
> I'm glad you asked... :)
> 
> MZ> considering each time it needs to contact user space for mapping a
> MZ> piece of data. 
> 
> Actually, that's not the case.  The idea is for mappings to be cached
> in the kernel module so that the communication with userspace only
> needs to happen once per block.  The thought is to ask once for a
> read, and then remember that mapping until a write happens, which
> might change the story.  If so, we ask userspace again.

sounds reasonable. saw the caching now.


> 
> Right now, the kernel module expires mappings in a pretty brain-dead
> way to make sure the list doesn't get too long.  An intelligent data
> structure and expiration method would probably improve performance
> quite a bit.
> 
> I don't have any benchmark data to post right now.  I did some quick
> analysis a while back and found it to be not too bad.  When using loop
> devices as a backing store, I achieved performance as high as a little
> under 50% of native.

o. :P 50% is a considerable amount. anyway, good start. ;)


> 
> MZ> and the size unit is per sector in dm?
> 
> Well, for qcow it is a sector, yes.  The module itself, however, can
> use any block size (as long as it is a multiple of a sector).  Before
> I started work on qcow support, I wrote a test application that used
> 2MiB blocks, which is where I got the approximately 50% performance
> value I described above.

pure read or read and write mixed?


> 
> Our thought is that this would mostly be used for the OS images of
> virtual machines, which shouldn't change much, which would help to
> prevent constantly asking userspace to map blocks.
> 

if this is the scenario, then may be more aggressive mapping can be used
here.

u might have interest on this. some developers are working on a general
scsi target layer that pass scsi cdb to user space for processing while
keep data transfer in kernel space. so both of u will meet same overhead
here. so 2 projects might learn from each other on this.

ps, trivial thing, the userspace_request is frequently used and can use
a slab cache.


ming



