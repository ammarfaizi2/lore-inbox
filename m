Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTKZT7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTKZT7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:59:15 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:33514 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264318AbTKZT7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:59:12 -0500
Message-ID: <3FC505F4.2010006@google.com>
Date: Wed, 26 Nov 2003 11:58:44 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>	<p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com>
In-Reply-To: <20031126113040.3b774360.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
  >
> Andi, I know this is a problem, but for the millionth time your idea
> does not work because we don't know if the user asked for the timestamp
> until we are deep within the recvmsg() processing, which is long after
> the packet has arrived.

How about tracking the number of current sockets that have had timestamp 
requests for them? If this number is zero, don't bother with the 
timestamps. The first time you get a SIOCGSTAMP ioctl on a given socket, 
bump the count and set a flag; decrement the count when the socket is 
destroyed if the flag is set.

The drawback is that the first SIOCGSTAMP on any particular socket will 
have to return a bogus value (maybe just the current time?). Ways to 
mitigate that are:

- have a /proc option to let the sysadmin enforce timestamps on all 
packets (just bump the counter)

- bump the counter whenever an interface is in promiscuous mode (I 
imagine that tcpdump et al are the main users of the timestamps?)

Paul

