Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWINGLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWINGLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWINGLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:11:14 -0400
Received: from gw.goop.org ([64.81.55.164]:462 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751357AbWINGLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:11:14 -0400
Message-ID: <4508F279.6010205@goop.org>
Date: Wed, 13 Sep 2006 23:11:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: torvalds@osdl.org, mingo@elte.hu, ak@suse.de, ebiederm@xmission.com,
       arjan@infradead.org, zach@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
References: <787b0d920609132023t1686525ei9c1703b044029909@mail.gmail.com>
In-Reply-To: <787b0d920609132023t1686525ei9c1703b044029909@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> We actually have an ABI problem right now because of this.
> Note that i386 and x86_64 use different GDT slots.
>
> As far as I can tell, users need to hard-code the mapping
> from TLS slot to segment number. They use 0,1,2 to ask the
> kernel to set things up (via set_thread_area), but can't
> just pop that into %fs or %gs.

That's not true at all.  The program I posted earlier in this thread 
uses set_thread_area() to allocate a GDT slot, and it works on both 
native 32 bit and 32-under-64.  The entry_number field in the struct 
user_desc is an actual entry number, so you can easily construct a 
selector from it.

> Typical hacks that result from this:
>
> call uname() and look for "x86_64"
> see of the addresses of local variables exceed 0xbfffffff
> examine /proc/1/maps
> check for a /lib64 directory
> change SSE register 8 in a signal handler frame and see if it sticks
> checksum the vdso code
> ...
>
> Please save us from these foul hacks.

Er, that all looks completely unnecessary.

    J
