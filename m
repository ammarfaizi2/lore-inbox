Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUJINV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUJINV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUJINVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:21:55 -0400
Received: from dsl-213-023-000-209.arcor-ip.net ([213.23.0.209]:50439 "EHLO
	be3.7eggert.dyndns.org") by vger.kernel.org with ESMTP
	id S266821AbUJINUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:20:19 -0400
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
To: linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Sat, 09 Oct 2004 15:24:06 +0200
References: <fa.haprsoi.8k8kbk@ifi.uio.no> <fa.isqjio8.ok2coo@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CGHCg-0001W5-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> People, get the heck over this.  The kernel has behaved this way
> for more than 3 years both in 2.4.x and 2.6.x.  The code in question
> even exists in the 2.2.x sources as well.
> 
> Therefore, it would be totally pointless to change the behavior
> now since anyone writing an application wishing it to work on
> all existing Linux kernels needs to handle this case anyways.

If you want people to write workaround for functions that intentional
break applications depending on dysfunctional behaviour, you should
document it. You didn't, and therefore most applications will be broken:

google survey:
Results 1 - 10 of about 13,100 for udp select recv. (0.18 seconds)
Results 1 - 10 of about 636 for udp select recv o_nonblock. (0.16 seconds)

Results 1 - 10 of about 4,350 for select recv SOCK_DGRAM. (0.40 seconds)
Results 1 - 10 of about 685 for select recv SOCK_DGRAM o_nonblock. (0.39
seconds) 


I think nobody complaining results from nobody sending bad UDP packets,
and nobody sending bad UDP packets resulted from nobody complaining.


BTW: If you're breaking select() for blocking sockets, you can as well
return -EBROKEN. It's as close to the specification as waiting after
guaranteeing not to wait, but it will not result in hidden flaws.
-- 
Fun things to slip into your budget
Request for 'supermodel access' to the UNIX server.
        Just don't tell the PHB why your home directory is named 'jpgs.'
