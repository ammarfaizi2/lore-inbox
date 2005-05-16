Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVEPUkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVEPUkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEPUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:40:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:26045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbVEPUkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:40:21 -0400
Date: Mon, 16 May 2005 13:40:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, davem@davemloft.net,
       herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: crypto api initialized late
Message-ID: <20050516204003.GV27549@shell0.pdx.osdl.net>
References: <20050516200317.GD23013@shell0.pdx.osdl.net> <OFBC11B5F7.2600BE34-ON85257003.006F5006-85257003.0070115B@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBC11B5F7.2600BE34-ON85257003.006F5006-85257003.0070115B@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Reiner Sailer (sailer@us.ibm.com) wrote:
> Chris Wright <chrisw@osdl.org> wrote on 05/16/2005 04:03:17 PM:
> > I'm surprised this helps at all.  Does this mean you are not using
> > security_initcall() in your module?
> 
> I use simply __initcall, which is the same level as the 
> module_initcall used in the crypto functions (sha1.c). Looking into 
> init.h, security_initcall should resolve to __initcall as well.

If you are compiling as a module (assuming that's not the case here),
then it's a normal module_init.  Otherwise it's put in it's own text
segment, and called during security_init(),  which is earlier than
do_inticalls() to ensure all objects get labeled.

> Changing the compile sequence orders, the crypto init and sha1 
> registration happens just ahead of my security module because
> (so I assume) the order of the compilation determines the order
> of the init calls inside the same initcall block.

Yes, it does.

thanks,
-chris
