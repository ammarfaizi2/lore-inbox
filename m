Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbULaTbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbULaTbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 14:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbULaTbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 14:31:44 -0500
Received: from [195.23.16.24] ([195.23.16.24]:48362 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262144AbULaTbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 14:31:42 -0500
Message-ID: <1104521356.41d5a88c041ff@webmail.grupopie.com>
Date: Fri, 31 Dec 2004 19:29:16 +0000
From: "" <pmarques@grupopie.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: Re: sh: inconsistent kallsyms data
References: <20041231172549.GA18211@linux-sh.org> <1104515971.41d593835721f@webmail.grupopie.com> <20041231182234.GB18211@linux-sh.org>
In-Reply-To: <20041231182234.GB18211@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.203
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Mundt <lethal@linux-sh.org>:

> On Fri, Dec 31, 2004 at 05:59:31PM +0000, pmarques@grupopie.com wrote:
> > I think the only change from 2.6.9 that could affect this is the
> > addition of the is_arm_mapping_symbol from Russel King.
> > 
> This wouldn't make any difference as that only gets invoked by
> read_symbol() for U type symbols, which is unrelated.


You mis-read the 'if'. The symbol is not used it is of 'U' type *or*
is_arm_mapping_symbol. This means that is_arm_mapping_symbol will be called for
all the symbols that are not of type 'U'.

Anyway, Keith Owens might be right. I forgot that this change only went into the
official tree now, and was under the impression that was already in 2.6.9 :(

It seems from the symptoms that the kallsyms_names array was 0x70 bytes larger
on the second run. This shouldn't happen if the algorithm is ran over the same
symbols, not matter how complex the algorithm is.

I was the one who wrote the algorithm, so I'm probably in the best position to
debug it. If you send Keith the info he requested, send it to me too, so that I
have some more data to look at.

--
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
