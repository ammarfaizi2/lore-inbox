Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUKPGEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUKPGEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUKPGDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:03:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17060 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261922AbUKPGBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:01:05 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI? 
In-reply-to: Your message of "Mon, 15 Nov 2004 21:18:43 -0000."
             <Pine.LNX.4.44.0411152110460.4171-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Nov 2004 17:00:10 +1100
Message-ID: <13456.1100584810@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004 21:18:43 +0000 (GMT), 
Hugh Dickins <hugh@veritas.com> wrote:
>On Fri, 12 Nov 2004, Horst von Brand wrote:
>> Dave Jones <davej@redhat.com> said:
>> > On Thu, Nov 11, 2004 at 09:05:11PM +0000, Hugh Dickins wrote:
>> >  > What is this "VLI" that 2.6.9 started putting after the taint string
>> >  > in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?
>> > 
>> > "Variable length instructions".  I think newer ksymoops looks
>> > for this tag and does something magical when doing disassembly.
>> 
>> Huh? Either an architecture has them (i386) or doesn't (RISCs). 
>> Or am I seriously misunderstanding here?
>
>I share your surprise, it does seem rather odd.  I think what it's
>really trying to do is distinguish how 2.6.9 starts the "Code:" bytes
>at eip - 43, where 2.6.8 started at eip; but flag that since it's VLI
>then it's got a bit of guessing to do.  I'd have preferred to work it
>out from i386 and the new "<%02x>" around the eip byte itself, rather
>than stick a "VLI" somewhere else; but let's not interfere now it's so.

ksymoops has to work with lots of different log formats from lots of
different architectures.  Some arch's already print the code around the
oops and enclose the failing instruction in <> or [], some do not.

Just looking at a code string, you cannot tell if the arch has variable
length instructions or not (don't forget that ksymoops also works cross
architecture).  The VLI tag will work for _all_ architectures that have
variable length instructions, not just i386.  At the very least, s390
can use it as well.

There are enough ambiguity problems in ksymoops, without adding new
ones.

