Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTIWV0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTIWV0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:26:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263436AbTIWV0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:26:42 -0400
Date: Tue, 23 Sep 2003 22:26:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Deepak Saxena <dsaxena@mvista.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030923212640.GM7665@parcelfarce.linux.theplanet.co.uk>
References: <20030923212207.GA25234@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923212207.GA25234@xanadu.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:22:07PM -0700, Deepak Saxena wrote:
> 
> The existing code in kernel/vsprintf.c:vsscanf() does not properly 
> handle the case where the format is specfied as %x or %X and the
> string contains the number in the format "0xinteger". Instead of
> reading "0xinteger", the code currently only sees the '0' and treats
> the 'x' as a delimiter. Following patch (against 2.4 and 2.6) fixes
> this.  Another option is to put the check in simple_strtoul() and
> simple_strtoull() if that is preferred. I like this better b/c
> we only have the check once.
 
	We should put that into strtoul().  Rationale:

<quote>
If the value of base is 16, the characters 0x or 0X may optionally precede
the sequence of letters and digits, following the sign if present.
</quote>

That's from C99 7.20.1.4 (definition of strtoul and friends) and it does
match the normal userland behaviour of strtoul(3) on all platforms I'd
seen...
