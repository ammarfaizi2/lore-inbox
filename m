Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTLBXRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLBXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:17:35 -0500
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:48814
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S264430AbTLBXRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:17:33 -0500
Message-ID: <3FCD1DB0.6040204@trash.net>
Date: Wed, 03 Dec 2003 00:18:08 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: James Bourne <jbourne@hardrock.org>, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org
Subject: Re: [netfilter-core] 2.4.23/others and ip_conntrack causing hangs
References: <20031202065849.779362C085@lists.samba.org>
In-Reply-To: <20031202065849.779362C085@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

>>Perhaps in dev_queue_xmit ? Otherwise packets stuck in queues hold
>>references to conntracks. Loopback traffic might cause some trouble
>>because the "previously seen?" expection in ip_conntrack_core wouldn't
>>work anymore.
>>    
>>
>
>But I wouldn't expect packets there to be held indefinitely, so I
>never worried about it.
>  
>

A prio qdisc for example can hold packets indefinitely as long as a higher
prio flow is active. I actually experienced problems unloading ip_conntrack
while playing with qdiscs until I removed the qdisc, but I hacked some stuff
before so it could be my own fault (and sometimes removing the qdisc didn't
help either). Anyways, it may be a corner case but I'm pretty sure there are
no lost references in ip_conntrack itself so maybe some of the sporadic
reports of hanging unload could be explained by this. I'm going to do some
more testing and then we can see.

Best regards,
Patrick



