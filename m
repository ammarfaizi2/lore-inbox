Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVKUWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKUWPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVKUWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:15:23 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:63492 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751107AbVKUWPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:15:21 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: cfriesen@nortel.com (Christopher Friesen)
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Cc: kuznet@ms2.inr.ac.ru, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <4382406D.1040508@nortel.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EeJwF-0006wc-00@gondolin.me.apana.org.au>
Date: Tue, 22 Nov 2005 09:15:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen <cfriesen@nortel.com> wrote:
> 
> When an NPTL child thread uses getpid() to specify the pid, it never 
> receives a response to this request.  Running the same code on the 
> parent works, and running the same code under Linuxthreads works.

As I said before, you should not rely on getpid() to work.  Any other
process in the system can bind to your pid which makes it unavailable
to your process.  In which case the kernel will pick an arbitrary
negative pid as your address.

You should always use getsockaddr(2) to get your local address.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
