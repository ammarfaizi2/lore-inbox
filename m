Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUGGIjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUGGIjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGGIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:37:59 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:4488 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265006AbUGGIcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:32:06 -0400
Subject: Re: VM - is "reserved memory for root" possible (in case of a
	leak)?
From: FabF <fabian.frederick@skynet.be>
To: Tomasz Chmielewski <mangoo@interia.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40EBA846.6010705@interia.pl>
References: <40EBA846.6010705@interia.pl>
Content-Type: text/plain
Message-Id: <1089189121.3692.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 07 Jul 2004 10:32:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 09:37, Tomasz Chmielewski wrote:
> Hello,
> 
> Short nature of a problem:
> 
> Recently I was playing with Apache2 as a proxy + mod_clamav as a virus 
> scanner, put some load to it, and in a short time hanged the machine 
> (actually, it was short of memory, and it stopped to respond - in logs I 
> saw VM was killing some other processes, unfortunately not Apache).
> 
> As I could reach the machine only remotely, it was no wonder I run into 
> troubles...
> 
> Sounds familiar?
> 
> 
> Solution?
> 
> I was thinking, if there is something like:
> 
> "reserved_min_memory_for_root = 10M"
> "reserved_min_memory_processes = /usr/sbin/sshd, /usr/sbin/pppd, etc.etc"
> 
> Which would just give that memory for those processes "once and for 
> all", and thus, saving trouble in case of a memory leak, uncontrolled 
> process, or similar.
> 
> I know it would be tricky to implement it, because the question arises, 
> what happens if we have no memory left, and these 
> "reserved_min_memory_processes" begin to grow?
> 
> But I think it would be something like a comparison:
> 
> ulimit vs this "reserved_min_memory_for_root", and
> quota vs -m option from mke2fs.
> 
> Is there something like it already in the kernel?
> 
> 
> It would be similar to mke2fs for the filesystem:
> 
> # man mke2fs
> 
> -m reserved-blocks-percentage
>                Specify the percentage of the filesystem blocks reserved 
> for the
>                super-user.  This value defaults to 5%
Hi Tomasz,

Maybe you would want to tune /proc/sys/vm/min_free_kbytes or renice +xx
apache.Some vmstat 1 report, uname -a could be interesting as
well.There's no per profile VM granularity in 2.6.

Regards,
FabF

> 
> 
> 
> Regards,
> 
> Tomasz Chmielewski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

