Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVDFMF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVDFMF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVDFMDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:03:37 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:29706 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S262179AbVDFL7O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:59:14 -0400
In-Reply-To: <20050406113233.GD7031@wohnheim.fh-wedel.de>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <14410feafdb3a83e1ae457b93e593b81@xs4all.nl>
Content-Transfer-Encoding: 8BIT
Cc: Blaisorblade <blaisorblade@yahoo.it>, jdike@karaya.com,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Greg KH <gregkh@suse.de>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Wed, 6 Apr 2005 14:04:39 +0200
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 6, 2005, at 1:32 PM, Jörn Engel wrote:

> On Tue, 5 April 2005 22:18:26 +0200, Renate Meijer wrote:
>>
>> If a function is prefixed with a double underscore, this implies the
>> function is internal to
>> the compiler, and may change at any time, since it's not governed by
>> some sort of standard.
>> Hence that code may start suffering from bitrot and complaining to the
>> compiler guys won't help.
>
> You did read include/linux/compiler.h, didn't you?

Yes. It seems a good place to hide compiler-internal stuff as the one 
this patch
implements. And I know linux does not exactly have a great track record
on this issue. But just because the dependency is there, does not imply 
it is a
GOOD THING to have it.

So instead of applying this patch, simply

#ifdef VERSION_MINOR < WHATEVER
#define va_copy __va_copy
#endif

in include/linux/compiler_gcc2.h

Thus solving the problem without having to invade compiler namespace all
over the place, but doing so in *one* place only.

> And you did read this thread as well, right?
> http://kerneltrap.org/node/4126

<quote>
Things seem to have improved a bit lately. The gcc-3.x series was
basically not worth it for plain C until 3.3 or so.
</quote>

Yes. You did read the actual data as produced by that guy from Suse, 
did you? In the past,
people may have justly stuck to (e.g.) 2.95.3, however, support for 
that version now starts to
require dependencies on compiler internals. This is one argument in 
favor of dropping support
for that version, or at least not to spread compiler dependent stuff 
all over the code.


