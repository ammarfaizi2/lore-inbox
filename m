Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTIYIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTIYIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:02:28 -0400
Received: from dyn-ctb-210-9-245-204.webone.com.au ([210.9.245.204]:60678 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261762AbTIYICY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:02:24 -0400
Message-ID: <3F72A0FE.6030201@cyberone.com.au>
Date: Thu, 25 Sep 2003 18:02:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org> <20030925075016.GG22525@vitelus.com>
In-Reply-To: <20030925075016.GG22525@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Aaron Lehmann wrote:

>On Thu, Sep 25, 2003 at 12:43:01AM -0700, Andrew Morton wrote:
>
>>An update to the 3ware driver was merged yesterday.  Have you used earlier
>>2.5 kernels?
>>
>
>Unfortunately not. I copied a day-old CVS tree to the machine but
>decided to update before compiling to get the latest-and-greatest. I
>did notice the 3ware updates.
>
>I rebooted with the deadline scheduler. It definately isn't helping.
>

OK, one problem is most likely something I added a month or so ago: a
new process is now assumed to be not a good anticipate candidate. This
solved some guy's obscure problem, but a lot of programs that benefit from
anticipation (ls, gcc, vi startup, cat, etc) are only going to submit a
few requests in their life, so they lose most of the gains. I have some
automatic thingy I'm testing at the moment.

The other problem could well be a big TCQ depth. AS helps with this, but
it can't do a really good job. Try a TCQ depth of max 4.


