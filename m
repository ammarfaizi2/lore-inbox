Return-Path: <linux-kernel-owner+w=401wt.eu-S932461AbXAITCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXAITCh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbXAITCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:02:37 -0500
Received: from web55602.mail.re4.yahoo.com ([206.190.58.226]:38394 "HELO
	web55602.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932449AbXAITCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:02:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=rd5F73yTk80aD4ExvnWDMI399rUsBwe8C5PpUKMZqBfEmy87Iq6G8OUDO8978j/HKyWQPxVArIDardlyCKZITn6EVYdH1ZJ7wYDmPCQt09XmPWskwRTR1HxmU625sTbWk3yZThGD4jT1qJa3xyvifaU3EVkS/9ErpKq5voTJQJs=;
X-YMail-OSG: Zg5dMkAVM1ntSq9awGODccDH2cmJPeW_PjRyFowNuw6M6y1Rw95WVbxkZQJdqxf6zA--
Date: Tue, 9 Jan 2007 11:02:35 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Valdis.Kletnieks@vt.edu
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200701082243.l08Mh8UR007559@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <88063.16727.qm@web55602.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:

> On Mon, 08 Jan 2007 01:06:12 PST, Amit Choudhary said:
> > I do not see how a double free can result in _logical_wrong_behaviour_ of the program and the
> > program keeps on running (like an incoming packet being dropped because of double free).
> Double
> > free will _only_and_only_ result in system crash that can be solved by setting 'x' to NULL.
> 
> The problem is that very rarely is there a second free() with no intervening
> use - what actually *happens* usually is:
> 
> 1) You alloc the memory
> 2) You use the memory
> 3) You take a reference on the memory, so you know where it is.
> 4) You free the memory
> 5) You use the memory via the reference you took in (3)
> 6) You free it again - at which point you finally know for sure that
> everything in step 5 was doing a fandango on core....
> 

Correct. And doing kfree(x); x=NULL; is not hiding that. These issues can still be debugged by
using the slab debugging options. One other benefit of doing this is that if someone tries to
access the same memory again using the variable 'x', then he will get an immediate crash. And the
problem can be solved immediately, without using the slab debugging options. I do not yet
understand how doing this hides the bugs, obfuscates the code, etc. because I haven't seen an
example yet, but only blanket statements.

But now I know better, since I haven't heard anything in support of this case, I have concluded
that doing kfree(x); x=NULL; is _not_needed_ in the "linux kernel". I hope that no one does it in
the future. And since people vehemently opposed this, I think its better to add another item on
the kernel janitor's list to remove all the (x=NULL) statements where people are doing "kfree(x);
x=NULL".

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
