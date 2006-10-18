Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWJRP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWJRP1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWJRP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:27:09 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:56200 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161179AbWJRP1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:27:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aBo/sgyKDZ6NU7XlC/KnTPY5xzBDbvjBH8yLuUSEsqjs/H3HomqyNDqP/LD7ugzyM7CojbBbNgPZRg0LZk6AzCBPQ0T4Buru8CJ1TmBfju6sV4IRXZ2qM0D1lkAAKuqeHmypPN/rNpCW3R5zFnMJW55yLJ6a1AtHiJLMBoYGk7Y=  ;
Message-ID: <453647C8.8040309@yahoo.com.au>
Date: Thu, 19 Oct 2006 01:27:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org> <4536446A.6000405@yahoo.com.au> <20061018151601.GR22289@parisc-linux.org>
In-Reply-To: <20061018151601.GR22289@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Oct 19, 2006 at 01:12:42AM +1000, Nick Piggin wrote:

>>Why not just WARN if it is already blocked as well? Presumably if the
> 
> 
> Because the driver can check the return value and fail the higher level
> operation.
> 
> 
>>driver needs nested blocking, it is going to have to carry some state
>>to know when to do the final unblock anyway, so it may as well just
>>not do these redundant blocks either.
> 
> 
> No driver needs nested blocking, but blocks may be imposed on a driver's
> device by the PCI core, for example.

So doesn't that mean it needs nested blocking? Surely that's better than
failing the operation due to an implementation detail.


>>** or ** just do a counting block/unblock to properly support nesting
>>them. That is, go one way or the other, and do it properly.
> 
> 
> I don't think that's necessary.  Right now, we have one user (IPR's
> BIST) and I'm trying to add a second (D-state transitions).  We don't
> need nested blocks, but we do need to fail in the highly unlikely case
> someone tries to do them.

Well if you really don't need nested blocking and you want to fail in
the highly unlikely case that someone tries... add the WARN.

> If it turns out we actually need them later, let's revisit this when we
> have a user.

I don't know much about the pci layer, so I'm sure you know better than
me whether they are needed or not. But if you think they are not, then
do the WARN rather than return failure.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
