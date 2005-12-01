Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVLAFZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVLAFZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLAFZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:25:52 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:22389 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932074AbVLAFZv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:25:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jMMwt0ejNSrEPqF2LEPAPMCKFD+ad7u/tCnTrc7dQI4OaNGh7bFslfLGJI57WclsU5e95WcnWT4oLpBGutXHj1MpDu+YjiLXPF/K3e0zbSUpCXSCx65QHZNo3WaP9IYgkP0yM2HZb41OT/MCBJjOXQdtvVSyT8KZTtZVKmSY61Q=
Message-ID: <2cd57c900511302125g9e771c6w@mail.gmail.com>
Date: Thu, 1 Dec 2005 13:25:50 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
Subject: Re: Why does insmod _not_ check for symbol redefinition ??
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0512010926460.1697-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133398629.8128.10.camel@localhost.localdomain>
	 <Pine.LNX.4.44.0512010926460.1697-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/1, Nagendra Singh Tomar <nagendra_tomar@adaptec.com>:
> On Thu, 1 Dec 2005, Rusty Russell wrote:
>
> > Sure.  It was due to minimalism.  If you override a symbol it's
> > undefined behavior.  It should be fairly simple to add a check that
> > noone overrides a symbol.  We didn't bother checking for it because it
> > wasn't clear that it was problematic.
>
> Thanx.
> Of all the problems (including kernel crashes, BUGs etc) one of the
> more serious  kinds are the ones where someone writes a new module and
> accidently  defines a function which has the same name as one of functions
> (say  foo_export),  already EXPORTed by either kernel proper or some
> loaded  module (as the  kernel is growing bigger chances of this happening
> is also  growing). The module happily loads and then some other module
> which wants  to use the function foo_export (obviously the one EXPORTed by
> kernel  proper and not the one overidden by the overiding module) is
> loaded. It  will also load happily but will get linked against the new
> foo_export,  defnitely not something that he wants. And, all this has
> happened without the kernel telling the user anything.
>         IMHO, these kind of silent errors are very dangerous and not
> something that should be acceptable.
> As you rightly said, it should be fairly straightforward to check for
> symbol redefinition. We need to do it only for the symbols EXPORTed by the
> loadable module.

This shouldn't happen if you only use in-tree modules as you should.
Don't take kernel modules as user mode applications.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
