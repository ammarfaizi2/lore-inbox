Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWEKIfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWEKIfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWEKIfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:35:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:61151 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030192AbWEKIfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:35:42 -0400
Message-ID: <4462F7F4.7050908@in.ibm.com>
Date: Thu, 11 May 2006 14:08:12 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Sharyathi Nagesh <sharyath@in.ibm.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
References: <444DFD53.2000108@in.ibm.com> <1145962096.3114.19.camel@laptopd505.fenrus.org> <1147332468.17798.13.camel@localhost.localdomain> <20060511073205.GA28693@flint.arm.linux.org.uk>
In-Reply-To: <20060511073205.GA28693@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Only the root should have a NULL parent, so this is just covering up some
>other problem - you have a resource which somehow has illegally ended up
>with a NULL parent pointer while it's been registered.
>
>Maybe try adding:
>
>		if (p->parent == NULL) {
>			printk("resource with null parent: %lx-%lx: %s\n",
>				p->start, p->end, p->name);
>			break;
>		}
>
>just before the test in that loop, and then finding out why that resource
>is becoming invalid.
>
>  
>
I get this output in dmesg with the above code.

resource with null parent: 0-57ffffff: System RAM
resource with null parent: 0-57ffffff: System RAM

x236:/home/sharyathi/linux-2.6.17-rc1/kernel # cat /proc/iomem
00000000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cafff : Video ROM
000cb000-000cc5ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-c7fcb5ff : System RAM
  00100000-004ff436 : Kernel code
  004ff437-0068881f : Kernel data
x236:/home/sharyathi/linux-2.6.17-rc1/kernel #



