Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTIJUpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbTIJUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:45:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25218 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262738AbTIJUpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:45:38 -0400
Date: Wed, 10 Sep 2003 16:48:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: James Clark <jimwclark@ntlworld.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
In-Reply-To: <3F5F8E90.4020701@techsource.com>
Message-ID: <Pine.LNX.4.53.0309101640550.18999@chaos>
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com>
 <Pine.LNX.4.53.0309041723090.9557@chaos> <3F5F8E90.4020701@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Timothy Miller wrote:

> I just have one quick question about all of this:
>
> People mention that driver interfaces don't change much in stable
> releases, but if memory serves, symbol versioning information changes
> with each minor release, requiring a recompile of modules.
>
> Would it be possible to have a driver module which can be dropped into,
> say, 2.6.17 that can also be dropped into 2.6.18 as long as the
> interface doesn't change?
>

Short answer, YES. Anything that can be done is possible. The
problem is that different kernel versions end up with different
structure members, etc. So, you can't use code for 2.2.xxx in
2.4.xx because, amongst other things, the first element in
'struct file_operations' was added and the others moved up.

Now, you can make a different module interface that maintains
a compatibility level ABI. This has been discussed. Unfortunately,
this adds code in the execution path. This extra code gets
executed every time the module code is accessed. The result being
that the module can't possibly operate as fast as it would if
there were no such compatibility layer(s). It might be "good enough",
but it is unlikely that the module contributors/maintainers would
allow such an interface because the loss of performance is measurable
and there has been no requirement to trade-off performance for
anything (your and my convenience doesn't count, those are not
technical issues).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


