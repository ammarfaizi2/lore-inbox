Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVAMIJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVAMIJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVAMIJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:09:41 -0500
Received: from [209.195.52.120] ([209.195.52.120]:60818 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261202AbVAMIJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:09:01 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jan 2005 00:02:01 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050113074234.GJ7048@alpha.home.local>
Message-ID: <Pine.LNX.4.60.0501122359190.20576@dlang.diginsite.com>
References: <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
 <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
 <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113072851.GN2995@waste.org>
 <20050113074234.GJ7048@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Willy Tarreau wrote:

> On Wed, Jan 12, 2005 at 11:28:51PM -0800, Matt Mackall wrote:
>> On Wed, Jan 12, 2005 at 08:48:57PM -0800, Linus Torvalds wrote:
>>>
>>>
>>> On Wed, 12 Jan 2005, Dave Jones wrote:
>>>>
>>>> For us thankfully, exec-shield has trapped quite a few remotely
>>>> exploitable holes, preventing the above.
>>>
>>> One thing worth considering, but may be abit _too_ draconian, is a
>>> capability that says "can execute ELF binaries that you can write to".
>>>
>>> Without that capability set, you can only execute binaries that you cannot
>>> write to, and that you cannot _get_ write permission to (ie you can't be
>>> the owner of them either - possibly only binaries where the owner is
>>> root).
>>
>> We can do that now with a combination of read-only and no-exec mounts.
>
> That's why some hardened distros ship with everything R/O (except var) and
> /var non-exec.

this only works if you have no reason to mix the non-exec and R/O stuff in 
the same directory (there is some software that has paths for stuff hard 
coded that will not work without them being togeather)

also it gives you no ability to maintain the protection for normal users 
at the same time that an admin updates the system. Linus's proposal would 
let you five this cap to the normal users, but still let the admin manage 
the box normally.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
