Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVBIUOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVBIUOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBIUOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:14:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261929AbVBIUNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:13:49 -0500
Date: Wed, 9 Feb 2005 15:13:36 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
In-Reply-To: <20050209153441.GA8809@nevyn.them.org>
Message-ID: <Pine.LNX.4.61.0502091512430.2108@chimarrao.boston.redhat.com>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org>
 <20050208175106.GA1091@elf.ucw.cz> <20050208111625.0bb1896d@dxpl.pdx.osdl.net>
 <20050208181018.5592beab.akpm@osdl.org> <20050209153441.GA8809@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Daniel Jacobowitz wrote:
> On Tue, Feb 08, 2005 at 06:10:18PM -0800, Andrew Morton wrote:

> It's asking for a lot of unwritable zeroed space.  See this:
>
>>   LOAD           0x000000 0x08048000 0x08048000 0xb7354 0x1b7354 R E 0x1000
>>   LOAD           0x0b7354 0x08200354 0x08200354 0x1e3e4 0x1f648 RW  0x1000

> clear_user's probably not the right way to provide the extra zeroing.

Indeed, clear_user() refuses to zero data when it's not writable
to the user process ...

unsigned long
clear_user(void __user *to, unsigned long n)
{
         might_sleep();
         if (access_ok(VERIFY_WRITE, to, n))
                 __do_clear_user(to, n);
         return n;
}

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
