Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTLBATq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTLBATq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:19:46 -0500
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:22693
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S264141AbTLBATp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:19:45 -0500
Message-ID: <3FCBDABF.6080804@trash.net>
Date: Tue, 02 Dec 2003 01:20:15 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: James Bourne <jbourne@hardrock.org>, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org
Subject: Re: [netfilter-core] 2.4.23/others and ip_conntrack causing hangs
References: <20031201015604.816D52C06F@lists.samba.org>
In-Reply-To: <20031201015604.816D52C06F@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>Unfortunately, some packets are still referencing connections, so the
>module *cannot* go away.  Figuring out exactly where the packets are
>referenced from is the fun part.  We explicitly drop the reference in
>ip_local_deliver_finish() for exactly this reason.  Perhaps there is
>somewhere else we should be doing the same thing.
>  
>
Perhaps in dev_queue_xmit ? Otherwise packets stuck in queues hold
references to conntracks. Loopback traffic might cause some trouble
because the "previously seen?" expection in ip_conntrack_core wouldn't
work anymore.

Best regards,
Patrick

>Hope that clarifies,
>Rusty.
>--
>  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


