Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWHUNyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWHUNyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWHUNyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:54:44 -0400
Received: from ns.firmix.at ([62.141.48.66]:7143 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1030476AbWHUNyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:54:43 -0400
Subject: Re: [take9 1/2] kevent: Core files.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060821130121.GA2602@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru>
	 <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru>
	 <20060818104607.GB20816@infradead.org> <20060818112336.GB11034@2ka.mipt.ru>
	 <20060821105637.GB28759@infradead.org> <20060821111335.GA8608@2ka.mipt.ru>
	 <1156164805.17936.132.camel@tara.firmix.at>
	 <20060821130121.GA2602@2ka.mipt.ru>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 21 Aug 2006 15:49:50 +0200
Message-Id: <1156168191.17936.149.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.378 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 17:01 +0400, Evgeniy Polyakov wrote:
[ #define vs enum { } ]
> And, ugh:
> 
> (gdb) list
> 1       enum {
> 2               A = 1,
> 3               B = 2,
> 4       };
> 5
> 6       int main()
> 7       {
> 8               printf("%x\n", A | B);
> 9       }
> (gdb) bre 8
> Breakpoint 1 at 0x4004ac: file ./test.c, line 8.
> (gdb) r
> Starting program: /tmp/test 
> 
> Breakpoint 1, main () at ./test.c:8
> 8               printf("%x\n", A | B);
> (gdb) p A
> No symbol "A" in current context.

Oops, I stand corrected.

> Actually I completely do not care about define or enums, it is really
> silly dispute, I just do not want to rewrite bunch of code _again_ and
> then _again_ when someone decide that defines are better.

ACK. Personally I also do not care that much - as long as it doesn't
change with the phase of the moon.
And we probably do not want
----  snip  ----
#ifdef CONFIG_I_LOVE_ENUMS
#define A 1
#define B 2
#define C 4
#else
enum {
	A = 1,
	B = 2,
	C = 4,
};
#endif
----  snip  ----
either.

	Bernd, shutting now up on this thread
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

