Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272123AbTGYOXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272124AbTGYOXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:23:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8909 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S272123AbTGYOXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:23:19 -0400
Date: Fri, 25 Jul 2003 09:38:09 -0500
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ihar Philips Filipau <filia@softhome.net>
To: Otto Solares <solca@guug.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030725042235.GA7777@guug.org>
Message-Id: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jul 24, 2003, at 23:22 US/Central, Otto Solares wrote:

> On Thu, Jul 24, 2003 at 11:20:00PM +0200, J.A. Magallon wrote:
>> Or you just define must_inline, and let gcc inline the rest of 
>> 'inlines',
>> based on its own rule of functions size, adjusting the parameters
>> to gcc to assure (more or less) that what is inlined fits in cache of
>> the processor one is building for...
>> (this can be hard, help from gcc hackers will be needed...)
>
> IMO just a CONFIG_INLINE_FUNCTIONS will work, if you
> want to conserve space in detriment of speed simply
> don't select this option, else you have speed but
> a big kernel.

Inlines don't always help performance (depending on cache sizes, branch 
penalties, frequency of code access...), but they do always increase 
code size.

I believe the point Alan was trying to make is not that we should have 
more or less inlines, but we should have smarter inlines. I.E. don't 
just inline a function to "make it fast"; think about the implications 
(and ideally measure it, though I think that becomes problematic when 
so many other factors can affect the benefit of a single inlined 
function). The specific example he gave was inlining code on the fast 
path, while accepting branch/cache penalties for non-inlined code on 
the slow path.

-- 
Hollis Blanchard
IBM Linux Technology Center

