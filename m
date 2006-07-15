Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWGOFjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGOFjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 01:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWGOFjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 01:39:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15778
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030188AbWGOFjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 01:39:53 -0400
Date: Fri, 14 Jul 2006 22:40:01 -0700 (PDT)
Message-Id: <20060714.224001.71089810.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060715010645.GB11515@gondor.apana.org.au>
References: <20060715002623.GE9334@gondor.apana.org.au>
	<20060714173517.cdd58097.akpm@osdl.org>
	<20060715010645.GB11515@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 15 Jul 2006 11:06:45 +1000

> -	__ret;						\
> +	unlikely(__ret);				\

Wouldn't it be cleaner to wrap this unlikely around
the top-level "({ })"?  When it sits on a line by
itself it looks strange, that much is true :)

Actually, the last time I saw a construct like this
it was a bug, someone was doing:

	return unlikely(someval);

which turned someval into a boolean, even though what
was intended was that the full value was returned.
