Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUFHKvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUFHKvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbUFHKvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:51:00 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:9614 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S264891AbUFHKu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:50:58 -0400
Message-ID: <40C5AA89.4060803@codeweavers.com>
Date: Tue, 08 Jun 2004 21:01:13 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu> <40C2D5F4.4020803@codeweavers.com> <1086507140.2810.0.camel@laptop.fenrus.com> <20040608092055.GX4736@devserv.devel.redhat.com> <40C59FE9.1010700@codeweavers.com> <20040608103221.GA7632@elte.hu>
In-Reply-To: <20040608103221.GA7632@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>>I did not investigate this, but others who did think that it is not
>>possible to create a segment that is reserve only so that does not
>>unnecessarily consume virtual memory. Apparently ELF allows it, but
>>Linux doesn't.
> 
> 
> what do you mean by "Linux doesn't"?

Apparently Linux will back all segments by swap space, even if they're 
marked as non-accessable.  Maybe I was told the wrong thing?  Or maybe 
the it's just difficult to create such a segment, as Jukub was saying?

In any case, the solution we have now reserves exactly the amount of 
memory that is needed.  If we were to use a fixed size segment, we would 
be reserving too much memory most of the time, and preventing shared 
libraries being loaded at their prefered addresses.

Mike
