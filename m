Return-Path: <linux-kernel-owner+w=401wt.eu-S1423148AbWLVAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423148AbWLVAbg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423147AbWLVAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:31:36 -0500
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:43873 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423148AbWLVAbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:31:35 -0500
In-Reply-To: <20061221222303.GA6418@localhost.localdomain>
References: <20061221222303.GA6418@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E5477CAE-3FE8-4441-9225-570DD0679765@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       libhugetlbfs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       William Lee Irwin <wli@holomorphy.com>, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Date: Fri, 22 Dec 2006 01:31:26 +0100
To: David Gibson <david@gibson.dropbear.id.au>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (len > TASK_SIZE)
> +		return -ENOMEM;

Shouldn't that be addr+len instead?  The check looks incomplete
otherwise.  And you meant ">=" I guess?

> -		/* Paranoia, caller should have dealt with this */
> -		BUG_ON((addr + len) > 0x100000000UL);
> -

Any real reason to remove the paranoia check?  If it's trivially
always satisfied, the compiler will get rid of it for you :-)

Cheers,


Segher

