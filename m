Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSH0AOQ>; Mon, 26 Aug 2002 20:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSH0AOQ>; Mon, 26 Aug 2002 20:14:16 -0400
Received: from fmr06.intel.com ([134.134.136.7]:63424 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S318243AbSH0AOP>; Mon, 26 Aug 2002 20:14:15 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB13299648@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'Michael Bellion'" <bellion@gmx.de>, linux-kernel@vger.kernel.org
Subject: RE: Finding out whether memory was allocated with kmalloc or vmal
	loc
Date: Mon, 26 Aug 2002 17:18:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bellion wrote:
> given a pointer p, is there an easy and platform independent way to find
out, 
> whether the memory location that p points to was allocated with kmalloc or

> vmalloc?

Try:
	#include <linux/mm.h>

	if (PageSlab(virt_to_page(p)) {
		/* this was allocated by mm/slab.c */
	} else {
		/* it wasn't ... may vmalloc'ed? */
	}

-Tony
