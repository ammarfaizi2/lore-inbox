Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVGMQWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVGMQWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVGMQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:22:34 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:11190 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262684AbVGMQWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:22:30 -0400
Date: Wed, 13 Jul 2005 18:22:27 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Vara Prasad <prasadav@us.ibm.com>
cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <42D52D77.3030706@us.ibm.com>
Message-ID: <Pine.BSO.4.62.0507131713570.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
 <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <17107.64629.717907.706682@tut.ibm.com>
 <Pine.BSO.4.62.0507121935500.6919@rudy.mif.pg.gda.pl> <42D42FE1.3080600@us.ibm.com>
 <Pine.BSO.4.62.0507131437200.6919@rudy.mif.pg.gda.pl> <42D52D77.3030706@us.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-369807221-1121271747=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-369807221-1121271747=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Jul 2005, Vara Prasad wrote:
[..]
> O.K, looks like you are agreeing that we need a buffering mechanism in the 
> kernel to implement speculative tracing, right.

Each agregator have own data. This data are buffered ..
In this sense: yes, it infrastructure for allocate, deallocate, copy ..
(generaly) operate on this buffers is needed.

> Once we have the buffering mechanism we need to create an efficient API 
> for producers of the data to write to that buffering scheme. To my 
> knowledge there is no such generic buffering mechanism already in the 
> kernel, Relayfs implements that buffering scheme and an efficient API to 
> write to it.  Isn't that a good reason to have Relayfs merged?

Sorry but not. Relayfs this is much more than it is required for simple 
manage buffers (better will be say in this point "probes data 
containers"). All this kind operation can be performed 
using reference/index.

> Once the data in the buffer is decided to be committed you need a mechanism 
> to get that data from the kernel to userspace. If you don't like Relayfs 
> transfer mechanism, what do you suggest using?

Correct me if I'm wrong .. ant try fill all this area where you see my
worse knowledge then yours or other strict kernel developers.

1) relayfs was prepared for low latency on move data outside kernel space,
2) getting data from probes do not require organize all them in regular
    file system structure also in most cases will do not require low latency.
    Only in all cases where buffer must be neccessarly moved outside kernel
    space will require minimal overhead.

Many other kernel sugbsystem allow transfer data as result of simple 
request with argument as reference/index. Organize all data stored/used by 
probes in named structure (if it is *realy* neccesary) can be IMO moved 
outside kernel space.
Why ? becase *all operations on kernel side on this data* seems can be 
performed without addidional namig abstraction (buffer number, buffer size 
and data type stored in buffer it will be all what is neccessary in 
probably all cases even in case operate on complex data).

If you realy want get data from probes via fopen()/read() why not map 
"probes data containers" to procfs/sysfs ? For reciving signals from 
perobes for move out of kernel space mapped buffer content and/or ALSO 
reciving signals with DATA (on request from user space) probably can be 
performed via existing netlink infrastrucrure or (higher) event 
notification.

(?)

Allow me ask you: do you try test is using netlink will allow perform
operations in neccessary time frame ? (with additional assumption agregate
maximum data possibly in "short range" from probe) .. probably not because 
most of skeleton ussages of KProbes and also LTT interface was prepared 
with assumption agregate data outside kernel space.
Do you see this ?

This was and sill is core cause of LTT problems and why it will never will 
be so usefull as DTrace. Agregate data in possible "short distance" from 
probe is *core DTrace assumption*. Simple .. this why using DTrace is
*very light* even if you are enable/hang thousands of probes inside kernel 
space and still it allwo use this kind of technik evel in very fragile 
(from point of view stabilyty) or under very high presure systems.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-369807221-1121271747=:6919--
