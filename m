Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbTFMCnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbTFMCnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:43:25 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:20997 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265108AbTFMCnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:43:25 -0400
Subject: Re: [PATCH] fix insidious bug with init section identification in
	the kernel module loader
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030613011906.923262C254@lists.samba.org>
References: <20030613011906.923262C254@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jun 2003 21:57:04 -0500
Message-Id: <1055473026.2117.59.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 20:18, Rusty Russell wrote:
> In message <1055452158.2117.52.camel@mulgrave> you write:
> > This problem manifests itself nastily on parisc, where the linker seems
> > to generate large number of elf sections, often one for each non static
> > function, with names like
> > 
> > .text.<function name>
> 
> -ffunction-sections, perhaps?

Yes, we only have nineteen bit branch relocations on the parisc1.1, so
we usually have to interleave trampoline stubs in between the function
sections to get from one end of the kernel to the other.

I suppose as long as we never get a module bigger than 256k, we don't
actually need to split modules up this way...

James


