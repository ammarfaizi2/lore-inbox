Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVJQCSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVJQCSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVJQCSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:18:48 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:26123 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751228AbVJQCSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:18:47 -0400
Date: Mon, 17 Oct 2005 11:18:51 +0900 (JST)
Message-Id: <20051017.111851.58669558.yoshfuji@linux-ipv6.org>
To: dleppik@vocalabs.com
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Re: PROBLEM: memory leak in LIST_*, TAILQ_* man page
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <43530379.6040504@vocalabs.com>
References: <43530379.6040504@vocalabs.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <43530379.6040504@vocalabs.com> (at Sun, 16 Oct 2005 20:50:49 -0500), David Leppik <dleppik@vocalabs.com> says:

> The man page for TAILQ_REMOVE, etc. contains the following sample code:
> 
> while (head.tqh_first != NULL)
>      TAILQ_REMOVE(&head, head.tqh_first, entries);
> 
> I checked /usr/include/sys/queue.h and, sure enough, TAILQ_REMOVE 
> doesn't free
> head.tqh_first.  Nor should it-- this isn't Objective-C, after all. :-)
> 
> It should be something like:
> 
> while (head.tqh_first != NULL) {
>               np = head.tqh_first;
>               TAILQ_REMOVE(&head, np, entries);
>               free(np);
> }

Wrong. People do not always destroy the item removed
from the list, I think.

--yoshfuji
