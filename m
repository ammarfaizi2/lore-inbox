Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUGGHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUGGHhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUGGHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:37:48 -0400
Received: from eri.interia.pl ([217.74.65.138]:27752 "EHLO eri.interia.pl")
	by vger.kernel.org with ESMTP id S264946AbUGGHhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:37:46 -0400
Message-ID: <40EBA846.6010705@interia.pl>
Date: Wed, 07 Jul 2004 09:37:42 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM - is "reserved memory for root" possible (in case of a leak)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Short nature of a problem:

Recently I was playing with Apache2 as a proxy + mod_clamav as a virus 
scanner, put some load to it, and in a short time hanged the machine 
(actually, it was short of memory, and it stopped to respond - in logs I 
saw VM was killing some other processes, unfortunately not Apache).

As I could reach the machine only remotely, it was no wonder I run into 
troubles...

Sounds familiar?


Solution?

I was thinking, if there is something like:

"reserved_min_memory_for_root = 10M"
"reserved_min_memory_processes = /usr/sbin/sshd, /usr/sbin/pppd, etc.etc"

Which would just give that memory for those processes "once and for 
all", and thus, saving trouble in case of a memory leak, uncontrolled 
process, or similar.

I know it would be tricky to implement it, because the question arises, 
what happens if we have no memory left, and these 
"reserved_min_memory_processes" begin to grow?

But I think it would be something like a comparison:

ulimit vs this "reserved_min_memory_for_root", and
quota vs -m option from mke2fs.

Is there something like it already in the kernel?


It would be similar to mke2fs for the filesystem:

# man mke2fs

-m reserved-blocks-percentage
               Specify the percentage of the filesystem blocks reserved 
for the
               super-user.  This value defaults to 5%



Regards,

Tomasz Chmielewski

