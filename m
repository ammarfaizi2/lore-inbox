Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSKDLdj>; Mon, 4 Nov 2002 06:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSKDLdj>; Mon, 4 Nov 2002 06:33:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58655 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264646AbSKDLdN>; Mon, 4 Nov 2002 06:33:13 -0500
Date: Mon, 4 Nov 2002 06:39:17 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Message-ID: <20021104063917.G10988@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <1036340502.29642.36.camel@irongate.swansea.linux.org.uk> <1036372893.752.11.camel@phantasy> <200211041112.gA4BCmp32103@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211041112.gA4BCmp32103@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Nov 04, 2002 at 02:04:42PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:04:42PM -0200, Denis Vlasenko wrote:
> Frankly, I'd say we should not inline anything large
> regardless of number of call sites, for reasons outlined above.
> 
> The limit is designed exactly for this purpose I think.

But the limit doesn't work that way. First of all, the limit
ATM is O(tree nodes) where it is not known how many tree nodes
will be one instruction or how many instructions will one tree node expand
into. That all depends on the exact code being inlined and how well
can it be optimized. Nice example are kernel's constant stringop inlines.
And also, there is the problem with inlining from inlines, it may very well
happen that gcc will inline a big function which is almost at the limit
boundary, but then not inline any of tiny functions which should be inlined
in it.

As kernel is using inline explicitely and not -O3, I think best would be
to use bigger inline limit and remove inline keywords from big functions
which should not be inlined.
Of course, improving gcc tree inliner is very desirable too.

	Jakub
