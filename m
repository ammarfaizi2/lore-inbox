Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312783AbSCZW5F>; Tue, 26 Mar 2002 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312798AbSCZW4z>; Tue, 26 Mar 2002 17:56:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50336 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312783AbSCZW4q>;
	Tue, 26 Mar 2002 17:56:46 -0500
Date: Tue, 26 Mar 2002 14:52:02 -0800 (PST)
Message-Id: <20020326.145202.122762468.davem@redhat.com>
To: maxk@qualcomm.com
Cc: rml@tech9.net, fisaksen@bewan.com, mitch@sfgoth.com,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        alan@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ATM locking fix.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm applying this patch with some minor cleanups of my own.

I went and then checked around for atm_find_dev() users to
make sure they held the atm_dev_lock, and I discovered several pieces
of "hidden treasure".

Firstly, have a look at net/atm/common.c:atm_ioctl() and how it
accesses userspace while holding atm_dev_lock.  That is just the
tip of the iceberg.

ATM sorely needs a maintainer.  Any of the kernel janitors want to
learn how ATM works? :-))))
