Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135847AbRAYSrN>; Thu, 25 Jan 2001 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135877AbRAYSrD>; Thu, 25 Jan 2001 13:47:03 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:7764 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S135847AbRAYSqu>;
	Thu, 25 Jan 2001 13:46:50 -0500
Message-ID: <3A70747F.2010305@valinux.com>
Date: Thu, 25 Jan 2001 11:46:23 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
		<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org> 
		<20010125165001Z132264-460+11@vger.kernel.org> <E14LpvQ-0008Pw-00@mail.valinux.com> 
		<20010125175308Z130507-460+45@vger.kernel.org> <E14Lqyt-0003z6-00@mail.valinux.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Thu, 25 Jan
> 2001 11:13:35 -0700
> 
> 
> 
>> You need to have your driver in the early bootup process then.  When 
>> memory is being detected (but before the free lists are created.), you 
>> can set your page as being reserved. 
> 
> 
> But doesn't this mean that my driver has to be built as part of the kernel?
> The end-user won't have the source code, so he won't be able to compile it, only
> link it.  As it stands now, our driver is a binary that can be shipped
> separately.

Sorry, this is the only way to do it properly.  Binary kernel drivers 
are intensely evil. ;)  Open the driver and you have no problems.  You 
also do know that binary kernel drivers mean you'll be chasing every 
kernel release, having to provide several different flavors of your 
binary depending on the users kernel configuration.  It also means that 
when kernel interfaces change, people won't be nice and change your code 
over to the new interfaces for you.  For instance if a function 
depreciates, your code might be automatically moved to use the 
replacement function if your in the standard kernel.  If your a binary 
module, you have to do all that maintaining yourself.

(There are several other reasons to have open kernel modules.  I won't 
go into the entire argument, since that could take all day.)

You might be able to get away with making detection of this page open, 
and keep the rest of the driver closed.  However that is something for 
Linus to decided, not I.  I believe he doesn't like putting in hooks in 
the kernel for binary modules.  Since all you really want to do is 
reserve the page during early bootup, perhaps he might let you get away 
with it.  Not my call though.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
