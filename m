Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUBAVQN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUBAVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:16:13 -0500
Received: from mail.tmr.com ([216.238.38.203]:19977 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265553AbUBAVQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:16:07 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Date: Sun, 01 Feb 2004 16:17:47 -0500
Organization: TMR Associates, Inc
Message-ID: <401D6CFB.2090501@tmr.com>
References: <20040130152835.GN31589@devserv.devel.redhat.com> <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com> <20040130171407.GA18320@hexapodia.org> <20040130194921.GO31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1075670140 10083 192.168.12.10 (1 Feb 2004 21:15:40 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Andy Isaacson <adi@hexapodia.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org
To: Jakub Jelinek <jakub@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040130194921.GO31589@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Fri, Jan 30, 2004 at 11:14:07AM -0600, Andy Isaacson wrote:
> 
>>On Fri, Jan 30, 2004 at 11:35:20AM -0500, James Morris wrote:
>>
>>>-	const u8 padding[64] = { 0x80, };
>>>+	static u8 padding[64] = { 0x80, };
>>
>>The RedHat bug suggests 'static const' as the appropriate replacement.
>>
>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=114610#c4
>>
>>Unfortunately that probably means an extra 64 bytes of text, rather than
>>the 10 or so bytes of instructions to do the memset and store.  Ideally
>>padding[] would be allocated in BSS rather than text or the stack (and
>>initialized with { 0x80, } at runtime), but I guess you can't have
>>everything.
> 
> 
> Or you can use
> 	u8 padding[64] = { 0x80 };
> if you really want to initialize it at runtime and want to work around the
> compiler bug.  It shouldn't be any less efficient than
> 	const u8 padding[64] = { 0x80 };
> since it is used just once, passed to non-inlined function.

I like this, as it avoids bloating the 64 bytes into the kernel.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
