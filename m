Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVGMQyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVGMQyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVGMQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:53:56 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:23698 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261208AbVGMQus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:50:48 -0400
Date: Wed, 13 Jul 2005 18:50:42 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Vara Prasad <prasadav@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: Merging relayfs?
In-Reply-To: <42D539BD.9060109@us.ibm.com>
Message-ID: <Pine.BSO.4.62.0507131827170.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
 <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <42D498AF.5070401@us.ibm.com>
 <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl> <42D539BD.9060109@us.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-709853852-1121273442=:6919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-709853852-1121273442=:6919
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Jul 2005, Vara Prasad wrote:
[..] 
> Looks like you have not looked at systemtap project although Tom pointed 
> about it to you in his previous postings.  The URL for systemtap is 
> http://sourceware.org/systemtap/, i strongly suggest you to look at that 
> project.

I'm just fill this gap.
Sorry but I cant't find in this document even single word about assumption 
about agregatre data possibly in short range from probe. But point 6.1 
this document says:

"Kernel-to-user transport Data collected from systemtap in the kernel must
                           ^^^^^^^^^^^^^^                              ^^^^
somehow be transmitted to userspace. This transport must
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
have high performance and minimal performance impact on the monitored 
system. One candidate is relayfs. Relayfs provides an efficient way to 
move large blocks of data from the kernel to userspace. The data is sent
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
in per-cpu beffers which a userspace program can save or display.
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Drawbacks are that the data arrives in blocks and is separated into 
per-cpu blocks, possibly requiring a post-processing step that stitches 
the data into an integrated steam. Relayfs is included in some recent -mm 
kernels. It can be built as a loadable module and is currently checked 
into CVS under src/runtime/relayfs. The other candidate is netlink. 
Netlink is included in the kernel. It allows a simple stream of data to be 
sent using the familiar socket APIs. It is unlikely to be as fast as
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
relayfs. Relayfs typically makes use of netlink as a control channel. With 
^^^^^^^
some simple extensions, the runtime can use netlink as the main transport 
too. So we can currently select in the runtime between relayfs and 
netlink, allowing us to support streams of data or blocks. And allowing us 
to perform direct comparisons of efficiency. [..]"

So .. using relayfs is neccessary because all collected data "must
somehow be transmitted to userspace" and this why must be transfered huge 
amout of data.

But if transering big amout of data will not be an issue seems netlink can 
be used for transfer data (generaly agregated) from kernel probes (?).
But also "with some simple extensions, the runtime can use netlink as the 
main transport too".
Even this document says "relayfs isn't neccessary fundament for 
systemtap". So .. why try to push for merge relayfs *NOW* ?
Because KProbes do not have expressions and some base agregators like 
couters isn't possibe to check NOW in real examples is realy realyfs is 
neccessary (?) :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-709853852-1121273442=:6919--
