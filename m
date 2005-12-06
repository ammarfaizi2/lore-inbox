Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbVLFDWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbVLFDWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbVLFDWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:22:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751561AbVLFDWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:22:10 -0500
Date: Tue, 6 Dec 2005 14:20:53 +1100
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, kir@sw.ru,
       devel@openvz.org, saw@sawoct.com, dim@sw.ru, st@sw.ru
Subject: Re: [ANNOUNCE] first stable release of OpenVZ kernel virtualization
 solution
Message-Id: <20051206142053.17793440.akpm@osdl.org>
In-Reply-To: <43949155.5060606@sw.ru>
References: <43949155.5060606@sw.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Hello,
> 
> We are happy to announce the release of a stable version of the OpenVZ 
> software, located at http://openvz.org/.
> 
> OpenVZ is a kernel virtualization solution which can be considered as a
> natural step in the OS kernel evolution: after multiuser and 
> multitasking functionality there comes an OpenVZ feature of having 
> multiple environments.

Are you able to give us a high-level overview of how it actually is
implemented?  IOW: what does the patch do?

> ...
> 
> As virtualization solution OpenVZ makes it possible to do the same 
> things for which people use UML, Xen, QEmu or VMware, but there are 
> differences:
> (a) there is no ability to run other operating systems
>      (although different Linux distros can happily coexist);
> (b) performance loss is negligible due to absense of any kind of
>      emulation;
> (c) resource utilization is much better.

What are OpenVZ's disadvantages wrt the above?

> The dynamic assignment of resources in OpenVZ can significantly improve 
> their utilization. For example, a x86_64 box (2.8 GHz Celeron D, 1GB 
> RAM) is capable to run 100 VPSs with a fairly high performance (VPSs 
> were serving http requests for 4.2Kb static pages at an overall rate of 
> more than 80,000 req/min). Each VPS (running CentOS 4 x86_64) had the 
> following set of processes:
> 
> [root@ovz-x64 ~]# vzctl exec 1043 ps axf
>   PID TTY      STAT   TIME COMMAND
>     1 ?        Ss     0:00 init
> 11830 ?        Ss     0:00 syslogd -m 0
> 11897 ?        Ss     0:00 /usr/sbin/sshd
> 11943 ?        Ss     0:00 xinetd -stayalive -pidfile ...
> 12218 ?        Ss     0:00 sendmail: accepting connections
> 12265 ?        Ss     0:00 sendmail: Queue runner@01:00:00
> 13362 ?        Ss     0:00 /usr/sbin/httpd
> 13363 ?        S      0:00  \_ /usr/sbin/httpd
> 13364 ?        S      0:00  \_ /usr/sbin/httpd
> 13365 ?        S      0:00  \_ /usr/sbin/httpd
> 13366 ?        S      0:00  \_ /usr/sbin/httpd
> 13370 ?        S      0:00  \_ /usr/sbin/httpd	
> 13371 ?        S      0:00  \_ /usr/sbin/httpd
> 13372 ?        S      0:00  \_ /usr/sbin/httpd
> 13373 ?        S      0:00  \_ /usr/sbin/httpd
> 6416 ?        Rs     0:00 ps axf

Do the various kernel instances share httpd text pages?

