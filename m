Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKKUVv>; Mon, 11 Nov 2002 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSKKUVv>; Mon, 11 Nov 2002 15:21:51 -0500
Received: from fmr02.intel.com ([192.55.52.25]:45519 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261290AbSKKUVu>; Mon, 11 Nov 2002 15:21:50 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC917@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: RE: PROT_SEM + FUTEX
Date: Mon, 11 Nov 2002 12:28:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am beginning to play with the FUTEX system call. I am hoping that
> PROT_SEM is not required, as I intend to scatter the words throughout
> memory, and it would be a real pain to mprotect(PROT_SEM) each page
> that contains a FUTEX word.

Still you want to group them as much as possible - each time you lock
a futex you are pinning the containing page into physical memory, that
would cause that if you have, for example, 4000 futexes locked in 4000 
different pages, there is going to be 4 MB of memory locked in ... it
helps to have an allocator that ties them together.

Cheers,

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
