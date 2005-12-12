Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLLTOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLLTOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVLLTOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:14:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932147AbVLLTN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:13:59 -0500
Date: Mon, 12 Dec 2005 11:13:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: anandhkrishnan@yahoo.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, rth@redhat.com, greg@kroah.com
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
 avoiding Undefined behaviour
Message-Id: <20051212111322.40be4cfe.akpm@osdl.org>
In-Reply-To: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
>
> When a symbol is exported from the kernel, and say, a module would
>  export the same symbol, there currently exists no mechanism to prevent
>  the module from exporting this symbol. The module would still go ahead
>  and export the symbol, the symbol table would now contain two copies
>  of the exported symbol, and hell would break loose.
> 
>  This patch prevents that from happening, by checking the symbol table
>  before relocation for all occurences of the Exported Symbol. If the
>  symbol already exists, we branch out with -ENOEXEC. Currently, this
>  search is sequential.

Do we really need to do this at runtime?  We could check this when building
module depoendencies (for example).  That'll be a 95% solution..
