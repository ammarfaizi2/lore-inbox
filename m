Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWJRPMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWJRPMs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWJRPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:12:48 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:43636 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161161AbWJRPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:12:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PYBijlfAx7tv5iK2+Pxuc0nUxAgoLIQBurevfKvSBpk5APwg+aWcW24FoW4jcr6JQaFkZNZ96Yo2ZThJf0UPl0L3zx17aYhowTAoOv1Ik90+3KvmEYXxTdUC7rDOYgz4BMh2mBo1He9MDp2N1BD1r+Dqebs3c3UlXw8GQGxCSIY=  ;
Message-ID: <4536446A.6000405@yahoo.com.au>
Date: Thu, 19 Oct 2006 01:12:42 +1000
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
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
In-Reply-To: <20061018145104.GN22289@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

> I also addressed the potential issue with nested attempts to block.
> Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> already unblocked device.

Why not just WARN if it is already blocked as well? Presumably if the
driver needs nested blocking, it is going to have to carry some state
to know when to do the final unblock anyway, so it may as well just
not do these redundant blocks either.

** or ** just do a counting block/unblock to properly support nesting
them. That is, go one way or the other, and do it properly.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
