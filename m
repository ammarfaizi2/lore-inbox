Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTDSEhB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTDSEhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:37:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263349AbTDSEhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:37:00 -0400
Message-ID: <3EA0D524.7010309@pobox.com>
Date: Sat, 19 Apr 2003 00:48:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
References: <20030419041526.5E3982C093@lists.samba.org>
In-Reply-To: <20030419041526.5E3982C093@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3E9FB2E9.9040308@pobox.com> you write:
> 
>>Rusty Trivial Russell wrote:
>>
>>>+char *kstrdup(const char *s, int gfp)
>>>+{
>>>+	char *buf = kmalloc(strlen(s)+1, gfp);
>>>+	if (buf)
>>>+		strcpy(buf, s);
>>>+	return buf;
>>>+}
>>
>>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
> 
> 
> Completely disagree.  Write the most straightforward code possible,
> and then if there proves to be a problem, optimize.  Optimizations
> where there's no actual performance problem should be left to the
> compiler.

Since the kernel does its own string ops, the compiler does not have 
enough information to deduce that further optimization is possible.


> Case in point: gcc-3.2 on -O2 on Intel is one instruction longer for
> your version.

And?  It's still slower.

	Jeff


