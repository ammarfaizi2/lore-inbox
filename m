Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269451AbRHCQIU>; Fri, 3 Aug 2001 12:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269438AbRHCQIK>; Fri, 3 Aug 2001 12:08:10 -0400
Received: from nef.ens.fr ([129.199.96.32]:40974 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S269437AbRHCQHw>;
	Fri, 3 Aug 2001 12:07:52 -0400
Date: Fri, 3 Aug 2001 18:07:49 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: ailinykh@usa.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010803180749.A42133@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net> you write:
> #define prepare_to_switch()     do { } while(0)

This one is a classic C trick; it is documented in the K&R book. With
this fake loop, the macro can be used like a statement anywhere. For
instance, compare the two following :

#define macro1()	{ /* some stuff */ }
#define macro2()	do { /* some stuff */ } while (0)

if (foo) macro1(); else bar;
if (foo) macro2(); else bar;

The second one is correct, but the first one is incorrect (the extra
semi-colon unlinks the `else' from the `if').


Besides, a fake loop, within or outside a macro, can be useful: you jump
out of it with a `break' statement; you could do it with a `goto' but
with the `break' you do not have to bother about managing label names.


	--Thomas Pornin
