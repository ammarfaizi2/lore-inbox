Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTJIRjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbTJIRjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:39:41 -0400
Received: from opersys.com ([64.40.108.71]:29969 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262303AbTJIRjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:39:40 -0400
Message-ID: <3F859DF1.8000602@opersys.com>
Date: Thu, 09 Oct 2003 13:42:09 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Morris wrote:
> It should be possible to make Netlink sockets mmapable (like the packet 
> socket).

So would you consider running printk on Netlink sockets? Do you think Netlink
could accomodate something as intensive as tracing? etc.

While I am aware that a lot of people are using Netlink sockets to exchange
data from the kernel to user-space, I don't think Netlink sockets can handle
the type of throughput relayfs can handle. Netlink and other communication
mechanisms (pipes, shared memory pages, etc.) were not designed to handle
the type of throughput relayfs was designed for. If nothing else, the use
of netlink also drags with it lots of networking code (netlink_sendmsg->
alloc_skb->kmalloc->etc. and then memcpy) With relayfs, you get direct
access to the buffer: relay_write->relay_write_direct (which is actually
a macro for memcpy()).

So yes, as you say, "It should be possible to make Netlink sockets mmapable",
but in that case you might as well port the netlink sockets API to relayfs
and you'll probably get better results.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

