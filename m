Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291851AbSBTNvj>; Wed, 20 Feb 2002 08:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291853AbSBTNv3>; Wed, 20 Feb 2002 08:51:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291851AbSBTNvW>;
	Wed, 20 Feb 2002 08:51:22 -0500
Message-ID: <3C73A9CE.932BF06F@mandrakesoft.com>
Date: Wed, 20 Feb 2002 08:51:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr> <m3zo27outs.fsf@defiant.pm.waw.pl> <20020218143448.B7530@fafner.intra.cogenit.fr> <m34rkdohu7.fsf@defiant.pm.waw.pl> <20020220143922.A13224@fafner.intra.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> Krzysztof Halasa <khc@pm.waw.pl> :
> [...]
> > Now... You just want to introduce an artificial struct which contains
> > only the union... Why?
> 
> Copy-paste abuse.
> 
> > We could use just the union instead (?).
> 
> Yes. I'll try that tonite.
> 
> [...]
> > Yes, the compiler would compile that. Anyway, don't you think it's
> > a little messy? Void * pointers are IMHO not that evil.
> 
> Once the union in a struct disappears it should be minimal.
> 
> Regarding void * against union/union * I feel like minimal type checking is
> better than none.

Agreed... the more type checking you can provide, the better.

Note that if it is possible to avoid the union in a manner that follows
the VFS inode cleanup, feel free to that too...  Basically each private
info struct looks like

	struct foo_inode {
		/* ... driver-private stuff here ... */
		struct inode vfs_inode;	/* last member of struct */
	};

Making it the last member of the structure ensures that people are not
tempted to do gross typecasting based on assumptions that the
"superclass" type is always located at the beginning of the subclass
substructure.  (I don't know how well that applies to this case, just a
suggestion...)

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
