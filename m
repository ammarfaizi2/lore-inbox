Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUJKMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUJKMek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUJKMeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:34:02 -0400
Received: from ozlabs.org ([203.10.76.45]:40639 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268890AbUJKMdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:33:07 -0400
Date: Mon, 11 Oct 2004 22:31:37 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Ricky lloyd <ricky.lloyd@gmail.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Cal Peake <cp@absolutedigital.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
Message-ID: <20041011123137.GB28100@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Ricky lloyd <ricky.lloyd@gmail.com>,
	Jan Dittmer <j.dittmer@portrix.net>,
	Cal Peake <cp@absolutedigital.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net> <416A7484.1030703@portrix.net> <1a50bd3704101105046e66538c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a50bd3704101105046e66538c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 05:34:20PM +0530, Ricky lloyd wrote:
> > Isn't the correct fix to declare iobase as (void __iomem *) ?
> > 
> 
> Earlier today i had posted a patch which mainly fixes this same
> problem with lotsa scsi
> drivers and tulip drivers. I wondered the same "shouldnt all the addrs
> be declared as
> void __iomem* ??". 

The trouble with that is that for some versions of the orinoco card,
the iobase refers to a legacy ISA IO address, not a memory-mapped IO
address (that's the inw()/outw() path in the macro).  That needs an
integer, rather than a pointer.

It's not clear to me which way around the cast is less ugly.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
