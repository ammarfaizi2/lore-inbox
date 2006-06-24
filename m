Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWFXQGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWFXQGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWFXQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:06:36 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:6736 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750854AbWFXQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:06:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iB4HbzX1PSFYwesy4xCtQ+brHCDWTTerJPYCWoPzfgfSgb/sQPNnKXj7QVAouF5UdPA0oFBV70aZ26Pc42eG8YuZCQdjTs4xcT7OIqnEF6d4GbEXojMYC69UrKzSPj7OP9dqnOUKZDROeSBfmhRdY3xdEMm45i3sf3Yo+yykb9M=  ;
Message-ID: <449D6305.4060303@yahoo.com.au>
Date: Sun, 25 Jun 2006 02:06:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
References: <200606231502.k5NF2jfO007109@hera.kernel.org>	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>	 <1151151104.3181.30.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com>	 <1151152059.3181.37.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>	 <1151153177.3181.39.camel@laptopd505.fenrus.org>	 <1151153635.3181.41.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0606240902390.23703@gandalf.stny.rr.com> <1151158295.3181.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1151158295.3181.46.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>The jne is expected to fail, so we will always continue to 0x13. Now is
>>this a problem with x86/x86_64?
> 
> 
> I'm not saying there is a problem; likely/unlikely do have an effect for
> sure, it's just not a "make it free" thing....

On x86 I think the main saving is the icache one. However I guess
gcc would try to align with the branch prediction behaviour for
unknown branches too.

The microoptimisation is that the call avoids the unlikely branch
in kfree. Maybe for x86 this isn't going to matter, but for some
architectures in might.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
