Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUCOJlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUCOJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:41:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:28124 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262476AbUCOJlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:41:46 -0500
Subject: Re: pmdisk suspend patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       swsusp-devel@lists.sourceforge.net
In-Reply-To: <20040315081323.37D3E7831D@mail.lmc.cs.sunysb.edu>
References: <c31t68$f99$1@sea.gmane.org> <1079332506.1966.152.camel@gaston>
	 <20040315081323.37D3E7831D@mail.lmc.cs.sunysb.edu>
Content-Type: text/plain
Message-Id: <1079343368.2348.156.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 20:36:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 19:13, Giridhar Pemmasani wrote:
> On Mon, 15 Mar 2004 17:35:07 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> said:
> 
>   Benjamin> I agree that it would be nice to be able to resume only
>   Benjamin> one "branch" of the PM tree like that, it's just not
>   Benjamin> possible at this point.
> 
> Thanks for your reply.
> 
> My understanding was that although it is a specific device that is
> being resumed, actual resume method is for the bus and that should
> power up the whole IDE subsystem. Am I wrong?

No. The bus "type" handler gets the resume and passes it along to the
device straight. You really need to walk the PM tree and wake up all
parents first, starting from the top of tree.

> I see that there is dependency branch information in
> dpm_active/dpm_off/dpm_off_irq. Isn't it possible to traverse these
> lists and power up parents for a device? What are the issues involved?
> 
> Cheers,
> Giri
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

