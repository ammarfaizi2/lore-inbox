Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129762AbRBSLge>; Mon, 19 Feb 2001 06:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbRBSLgX>; Mon, 19 Feb 2001 06:36:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129762AbRBSLgR>; Mon, 19 Feb 2001 06:36:17 -0500
Subject: Re: Linux 2.4.1-ac15
To: prumpf@mandrakesoft.com (Philipp Rumpf)
Date: Mon, 19 Feb 2001 11:35:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        prumpf@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <Pine.LNX.3.96.1010219034311.16489B-100000@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Feb 19, 2001 03:47:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Uob0-0003Cs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The module list is modified atomically, so either we search the new table
> or we don't, but we never see intermediate states.  Not searching the new
> table shouldn't be a problem as we shouldn't run module code until
> sys_init_module time.

The problem isnt running module code. What happens in this case

        mod->next = module_list;
        module_list = mod;      /* link it in */

Note no write barrier.

Delete is even worse

We unlink the module
We free the memory

At the same time another cpu may be walking the exception table that we free.



