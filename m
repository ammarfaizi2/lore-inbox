Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVAZHkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVAZHkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVAZHkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:40:04 -0500
Received: from holomorphy.com ([66.93.40.71]:11959 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262372AbVAZHkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:40:00 -0500
Date: Tue, 25 Jan 2005 23:39:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       spyro@f2s.com
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050126073948.GJ10843@holomorphy.com>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <m1zmyw4rlj.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmyw4rlj.fsf@muc.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:
>> It is possible for one task to end up "owning" an mm from another - we
>> have seen this with the procfs code when process 1 accesses
>> /proc/pid/cmdline of process 2 while it is exiting.  Process 2 exits
>> but does not tear its mm down. Later on process 1 finishes with the proc
>> file and the mm gets torn down at this point.

On Wed, Jan 26, 2005 at 07:44:24AM +0100, Andi Kleen wrote:
> IMHO that's the root bug. That sounds really dangerous and will likely
> cause other problems because it is totally unexpected. How about fixing
> /proc to not do this?

It would not be meaningful. It's a natural outcome of reference
counting the mm, /proc/ is far from the only place that acquires
references on mm's, and they're all necessary.


-- wli
