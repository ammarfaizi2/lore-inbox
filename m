Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUEQRdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUEQRdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUEQRb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:31:26 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:59840 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261932AbUEQRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:30:46 -0400
In-Reply-To: <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk>
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org> <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E88DCF88-A827-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: hugh@veritas.com, elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       support@bitmover.com, Linus Torvalds <torvalds@osdl.org>,
       Wayne Scott <wscott@bitmover.com>, adi@bitmover.com, akpm@osdl.org,
       wli@holomorphy.com, lm@bitmover.com, "Theodore Ts'o" <tytso@mit.edu>
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page?
Date: Mon, 17 May 2004 11:30:36 -0600
To: viro@parcelfarce.linux.theplanet.co.uk
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 17, 2004, at 9:37 AM, viro@parcelfarce.linux.theplanet.co.uk 
wrote:

> On Mon, May 17, 2004 at 08:22:10AM -0700, Linus Torvalds wrote:
>>
>>
>> On Mon, 17 May 2004, Theodore Ts'o wrote:
>>>
>>> Note though that the stdio library uses a writeable mmap to implement
>>> fwrite.
>>
>> It does? Whee. Then I'll have to agree with Andrew - if there is a 
>> path
>> that is more likely to have bugs, it's trying to do writes with mmap 
>> and
>> ftruncate.
>>
>> Who came up with that braindead idea? Is it some crazed Mach developer
>> that infiltrated the glibc development group?
>
> IIRC, that idiocy had been disabled by default (note that it's 
> inherently
> broken, since truncate() between your mmap() and memcpy() will lead to
> a coredump, which is not something fwrite() is allowed to do in such
> situation).
>
> strace should show if there such mmap calls are made, anyway.  Did they
> show up in the traces?
>
>

These calls show up in an strace which I did from a non-failing system,
but which has the same glibc as the failing system:

mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40018000
old_mmap(NULL, 19184, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000

The command was the following, with the result "Nothing to pull".
strace bk pull bk://linux.bkbits.net/linux-2.5

There were 52 instances of mmap2 or old_mmap in the saved script log.

	Steven

