Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWHQOmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWHQOmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWHQOmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:42:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36767 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965067AbWHQOm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:42:26 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155824788.9274.32.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 16:01:57 +0100
Message-Id: <1155826917.15195.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 07:26 -0700, ysgrifennodd Dave Hansen:
> My main thought is that _everybody_ is going to have to live with the
> entry in the 'struct page'.  Distros ship one kernel for everybody, and
> the cost will be paid by those not even using any kind of resource
> control or containers.
> 
> That said, it sure is simpler to implement, so I'm all for it!

I don't see any good way around that. For the page struct it is a
material issue, for the others its not a big deal providing we avoid
accounting dumb stuff like dentries.

At the VM summit Linus suggested one option for user page allocation
tracking would be to track not per page but by block of pages (say the
2MB chunks) and hand those out per container. That would really need the
defrag work though.


