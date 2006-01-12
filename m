Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWALBeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWALBeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWALBeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:34:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:63912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964957AbWALBeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:34:12 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 02:33:51 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120156.11529.ak@suse.de> <1137029233.17705.46.camel@localhost.localdomain>
In-Reply-To: <1137029233.17705.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120233.51601.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 02:27, Bryan O'Sullivan wrote:

> > > +__raw_memcpy_toio32:
> > > +	movl %edx,%ecx
> > > +	shrl $1,%ecx
> > 
> > 1? If it's called memcpy it should get a byte argument, no? If not
> > name it something else, otherwise everybody will be confused. 
> 
> It's called toio32 for a reason :-)
> 
> Also, the kernel doc clearly states its purpose.

I think it's deeply wrong to reuse names of standard functions with different
arguments. Either pass bytes or give it some other name.
 
> > movsq? I thought you wanted 32bit IO? 
> 
> The northbridge will split qword writes into pairs of dword writes.

That sounds like a very chipset specific assumption. Is that safe
to make? If yes you would need to document it clearly. But most likely
it's not a good idea to do this. Even if it works right now it would
be another death trap for the next user.

-Andi
