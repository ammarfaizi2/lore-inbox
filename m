Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTKAWLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTKAWLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 17:11:08 -0500
Received: from tiktok.demon.co.uk ([62.49.19.48]:36811 "EHLO
	philip.southpark.org") by vger.kernel.org with ESMTP
	id S261152AbTKAWLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 17:11:05 -0500
Message-ID: <3FA42F77.5010508@javascript-games.org>
Date: Sat, 01 Nov 2003 22:11:03 +0000
From: Scott Porter <scott@javascript-games.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Type conflicts in in.h header files.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    This is my first posting here, I'm not subscribed so I'd appreciate 
any responses via email (although I will scan the lkml via Google).

    There appears to be a conflict between the structures defined in the 
following files:
        /usr/include/linux/in.h
        /usr/include/netinet/in.h

    The kernel source I am using:
       2.4.20-gentoo-r5 (I assume the Gentoo patches wouldn't cause this 
though?)

    I'm not much of a C programmer, but I'm attempting to build an old 
daemon called "mrouted" to allow me to set up a multicast router using 
linux (there doesn't seem to be ANY current documentation about this, so 
I'm assuming I still need to use this daemon?!). The kernel was compiled 
with all routing options enabled. Here's a partial error log during the 
build:

gcc -D__BSD_SOURCE  -Ibsd -O -Iinclude-linux  -DRSRR       -c -o igmp.o 
igmp.c
In file included from /usr/include/linux/mroute.h:5,
                 from defs.h:34,
                 from igmp.c:14:
/usr/include/linux/in.h:25: conflicting types for `IPPROTO_IP'
/usr/include/netinet/in.h:32: previous declaration of `IPPROTO_IP'
/usr/include/linux/in.h:26: conflicting types for `IPPROTO_ICMP'
/usr/include/netinet/in.h:36: previous declaration of `IPPROTO_ICMP'
/usr/include/linux/in.h:27: conflicting types for `IPPROTO_IGMP'
/usr/include/netinet/in.h:38: previous declaration of `IPPROTO_IGMP'
/usr/include/linux/in.h:28: conflicting types for `IPPROTO_IPIP'
/usr/include/netinet/in.h:40: previous declaration of `IPPROTO_IPIP'

    I did "fix" this problem by symlinking linux/in.h -> netinet/in.h, 
however, this may have caused other problems during the build, but 
that's my problem I guess!

    Cheers,
                Scott

-- 
Scott Porter

