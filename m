Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFXJB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFXJB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXJB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:01:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:57054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263818AbUFXJB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:01:26 -0400
Date: Thu, 24 Jun 2004 02:00:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-Id: <20040624020022.0601d4ae.akpm@osdl.org>
In-Reply-To: <20040624070936.GB30057@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> gcc 3.4 gained support for several typical bitops as builtin directives.
>  Using these over inline asm has a few advantages:
>  * gcc can optimize constants into these better
>  * gcc can reorder and schedule the code better
>  * gcc can allocate registers etc better for the code
> 
>  The question is if we consider it desirable to go down this road or not. In
>  order to help that discussion I've attached a patch below that switches the
>  i386 ffz() function to the gcc builtin version, conditional on gcc having
>  support for this. Before I go down the road of converting more functions
>  and/or architectures.... is this worth doing?

I guess it depends on the resulting code size and quality.  Some extra
conversions would be needed for that.

For the implementation it would be nice to have the old-style
implementations in one header and the new-style ones in a separate header. 
That would create a bit of an all-or-nothing situation, but that should be
OK?

>  +static inline unsigned long ffz (unsigned long word) 
>  +{ 
>  +	return __builtin_ctzl (~word); 
>  +}

eww, whitepsace innovations.

static inline unsigned long ffz(unsigned long word) 
{ 
	return __builtin_ctzl(~word); 
}

