Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUF1OPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUF1OPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUF1OPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:15:51 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:6592 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S264965AbUF1OPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:15:50 -0400
Date: Mon, 28 Jun 2004 10:15:17 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Oliver Neukum <oliver@neukum.org>, zaitcev@redhat.com, greg@kroah.com,
       arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628141517.GA4311@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040627142628.34b60c82.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 02:26:28PM -0700, David S. Miller wrote:
> On Sun, 27 Jun 2004 12:42:21 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> > OK, then it shouldn't be used in this case. However, shouldn't we have
> > an attribute like __nopadding__ which does exactly that?
> 
> It would have the same effect.  CPU structure layout rules don't pack
> (or using other words, add padding) exactly in cases where it is
> needed to obtain the necessary alignment.

No, it wouldn't, as you could drop the assumption that the base of
the struct can be misaligned.  Thus, the compiler only needs to
generate unaligned loads and stores for fields which are unaligned
within the struct, which in this case would be none of them.

While it's rather unlikely that a struct like this one would ever
need packing, it would help those structs that do need it by reducing
the number of fields subjected to unaligned loads and stores.

-Scott
