Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTJEQgU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTJEQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:36:20 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:42396
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263151AbTJEQgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:36:19 -0400
Message-ID: <3F80484A.3030105@redhat.com>
Date: Sun, 05 Oct 2003 09:35:22 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       pwaechtler@mac.com, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
References: <Pine.GSO.4.58.0310051047560.12323@ultra60>
In-Reply-To: <Pine.GSO.4.58.0310051047560.12323@ultra60>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:

> There are a lot of differencies but if the most important one is use of
> ioctl vs syscalls it can be changed (in fact our implementation loong time
> ago used syscalls).

Syscalls are always better.  At least from my perspective.  Just imagine
how the runtime should determine that the kernel doesn't support msqs?
With syscalls I get -ENOSYS back.  With ioctls I get EINVAL.  But what
this mean?  Functionality not available?  Invalid parameters to the
existing implementation?

ALso think about strace which is an important part in many peoples life.
 Hiding the functionality in some ioctls doesn't make it easy to follow
the program even if strace gets even more code added to the ioctl decoder.

Basically, demultiplexers are bad.  Syscalls are cheap.


> In another words: is our implementation in the position
> of NGPT or better? ;-)

I don't understand.  Why NGPT and what about "position"?  If you mean
including a solution in the runtime (librt), sure, this will happen.
But not before I see a solution in the official kernel.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

