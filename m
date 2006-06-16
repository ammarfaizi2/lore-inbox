Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWFPHXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWFPHXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 03:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWFPHXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 03:23:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:33956 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751121AbWFPHXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 03:23:41 -0400
Message-ID: <44925C78.7030100@suse.de>
Date: Fri, 16 Jun 2006 09:23:36 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <12c511ca0606151144i140c21e5w90dd948af9b536a4@mail.gmail.com> <200606160822.23898.ak@suse.de>
In-Reply-To: <200606160822.23898.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Alternatively it means that this will almost always do the right thing, but
>> once in a while it won't, your application will happen to have been migrated
>> to a different cpu/node at the point it makes the call, and from then on
>> this instance will behave oddly (running slowly because it allocates most
>> of its memory on the wrong node).  When you try to reproduce the problem,
>> the application will work normally.
> 
> That's inherent in NUMA. No good way around that.

Hmm, maybe it makes sense to allow binding memory areas to threads
instead of nodes.  That way the kernel may attempt to migrate the pages
to another node in case it migrates threads / processes.  Either via
mbind(), or maybe better via madvise() to make clear it's a hint only.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
