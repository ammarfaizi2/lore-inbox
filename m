Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUFSLKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUFSLKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 07:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUFSLKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 07:10:34 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43201 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265487AbUFSLKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 07:10:33 -0400
Date: Sat, 19 Jun 2004 13:09:58 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wmb versus smp_wmb
Message-ID: <20040619130958.A32669@electric-eye.fr.zoreil.com>
References: <5.1.0.14.2.20040619122933.00afee60@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20040619122933.00afee60@pop.t-online.de>; from margitsw@t-online.de on Sat, Jun 19, 2004 at 12:32:32PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margit Schubert-While <margitsw@t-online.de> :
> As the $SUBJECT implies, when should one use
> wmb() versus smp_wmb() ?

If the code which must see the variable(s) modified before the
wmb() can run on a separate CPU, then it should be a smp_wmb().

For instance host H1 wants to update A then B and host H2 needs to
be sure that if it reads the updated value of B, then it reads
the updated value of A as well. B could be an event that uses a
different channel instead of a memory update.

Usually (for me :o) ), the issue between the two (or more) CPUs is
complicated by the fact that there is some device behind a PCI bus
whose behavior depends on the same data as well.

Suggested reading: Schimmel + Aspirin recommended use.

--
Ueimor
