Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUGKCpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUGKCpa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUGKCp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:45:29 -0400
Received: from CPE-203-51-26-230.nsw.bigpond.net.au ([203.51.26.230]:26606
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S266487AbUGKCp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:45:28 -0400
Message-ID: <40F0A9C4.9000405@eyal.emu.id.au>
Date: Sun, 11 Jul 2004 12:45:24 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>	<Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org> <52r7rj7txj.fsf@topspin.com>
In-Reply-To: <52r7rj7txj.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Suppose I have
> 
> 	struct foo {
> 		int a;
> 		int b;
> 	};
> 
> then sparse is perfectly happy with someone clearing out a struct foo
> like this:
> 
> 	struct foo bar = { 0 };
> 
> but then if someone changes struct foo to be
> 
> 	struct foo {
> 		void *x;
> 		int a;
> 		int b;
> 	};
> 
> sparse will complain about that initialization, and all of the fixes
> I can think of seem somewhat worse than the original to me:

Come on, this is madness. By accident, the first memeber which
changed from 'int' to 'void *' now accepts the old initializer.
In my book this is a really bad thing because you just changed
the semantics of the initialiser '{ 0 }' quietly.

BTW, if nothing else, don't add new members at the top.

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
