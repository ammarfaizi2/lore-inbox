Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVAQUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVAQUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAQUW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:22:57 -0500
Received: from one.firstfloor.org ([213.235.205.2]:22728 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262869AbVAQUWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:22:54 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
	<20050114205651.GE17263@kam.mff.cuni.cz>
	<Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
	<cs9v6f$3tj$1@terminus.zytor.com>
	<Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
	<1105955608.6304.60.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
	<41EBFF87.6080105@zytor.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 17 Jan 2005 21:22:53 +0100
In-Reply-To: <41EBFF87.6080105@zytor.com> (H. Peter Anvin's message of "Mon,
 17 Jan 2005 10:10:15 -0800")
Message-ID: <m1wtubvm8y.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Tigran Aivazian wrote:
>> On Mon, 17 Jan 2005, Arjan van de Ven wrote:
>>
>>>> Actually, having cc'd Linus made me think very _carefully_ about what I
>>>> say and I went and checked how the userspace does it, as I couldn't
>>>> believe that such fine piece of software as gdb would be broken as well.
>>>> And to my surprize I discovered that gdb (when a program is
>>>> compiled with
>>>> -g) works fine! I.e. it shows the function arguments correctly. And
>>>
>>> so why don't you use kgdb instead of kdb ?
>> If kdb was some dead unmaintained piece of software then, yes, I
>> would follow your advice and switch to kgdb. But kdb is a very nice
>> and actively maintained piece of work, so it should be fixed to show
>> the parameter values correctly in the backtrace.
>
> That's a kdb maintainer issue.  The x86-64 folks have nicely provided
> a set of libraries to do backtraces, etc.  Your previous rant is just
> so far off base it's not even funny.

To be fair there isn't a nice library for it on x86-64.  There
is libunwind on IA64, but afaik nobody ported it to x86-64 yet.

Just various projects have their own private unwind
implementation. The kernel including KDB has always lived with
imprecise backtraces and no argument printing. I don't think it has
been a show stopper so far.  If you really want the arguments you can
always use kgdb.

However I'm not sure we really want libunwind in the kernel anyways
(not even in KDB ;-) If anything better something stripped down and 
simple which libunwind isn't.

Unfortunately dwarf2 is not exactly a simple spec so implementing
a new backtracer for the kernel is not a trivial task. 

-Andi
