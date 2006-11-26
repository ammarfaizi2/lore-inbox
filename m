Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935352AbWKZVG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935352AbWKZVG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935562AbWKZVG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 16:06:58 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:12498 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S935352AbWKZVG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 16:06:57 -0500
Date: Sun, 26 Nov 2006 22:06:12 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Roland Dreier <rdreier@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
Message-ID: <20061126210612.GD6807@wohnheim.fh-wedel.de>
References: <adazmag5bk1.fsf@cisco.com> <20061124.220746.57445336.davem@davemloft.net> <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net> <adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org> <ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org> <Pine.LNX.4.64.0611261208550.3483@woody.osdl.org> <adapsba2bvj.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adapsba2bvj.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 November 2006 12:26:08 -0800, Roland Dreier wrote:
> 
>  > +#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
>  > +#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
> 
> Fine by me, but it loses the extra (typeof(x)) cast that Al wanted to
> make sure that the result of ALIGN() is not wider than x.

Not a big deal, is it?

#define ALIGN(x,a)		(typeof(x))__ALIGN_MASK(x,(typeof(x))(a)-1)
#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))

Jörn

-- 
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979
