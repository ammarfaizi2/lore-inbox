Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUBXDMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUBXDMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:12:47 -0500
Received: from everest.2mbit.com ([24.123.221.2]:7367 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261653AbUBXDMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:12:33 -0500
Message-ID: <403AC0F3.7050107@greatcn.org>
Date: Tue, 24 Feb 2004 11:11:47 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org> <20040221163213.GB15991@mail.shareable.org> <403984DD.4030108@greatcn.org> <20040223143056.GC30321@mail.shareable.org>
In-Reply-To: <20040223143056.GC30321@mail.shareable.org>
X-Scan-Signature: ab34628d8ad4c181d7650a5975d803f3
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Remove the extra jmp
Content-Type: multipart/mixed;
 boundary="------------000005060108060709010805"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005060108060709010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jamie Lokier wrote:
> 
> Your patch uses two instructions to flush the queue (push+ret) instead
> of one (jmp or ljmp).  Is that documented as reliable?  I can easily
> imagine an implementation which decodes one instruction after a mode
> change predictably, but not two.
> 
> I doubt that it makes a difference - we're setting PG, not changing
> the instruction format - but I'd like us to be sure it cannot fail on
> things like 386s and 486s, and similar non-Intel chips.

push+ret is encouraged/borrowed/stolen from FreeBSD ;) it should be 
reliable. And also, old linux uses ret. Since old linux runs on 386, it 
is quite reliable. If you still doubt, we can push before PG.



Hello Anvin,

Please either take the push+ret patch or take the one near jmp patch 
enclosed in this email. thanks

	Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

--------------000005060108060709010805
Content-Type: text/plain;
 name="patch-cy0402240-2.6.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402240-2.6.3"

--- head.S.orig	2004-02-18 11:57:16.000000000 +0800
+++ head.S	2004-02-24 11:08:34.000000000 +0800
@@ -117,9 +117,6 @@
 	movl %eax,%cr0		/* ..and set paging (PG) bit */
 	jmp 1f			/* flush the prefetch-queue */
 1:
-	movl $1f,%eax
-	jmp *%eax		/* make sure eip is relocated */
-1:
 	/* Set up the stack pointer */
 	lss stack_start,%esp
 

--------------000005060108060709010805--
