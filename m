Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVCLW33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVCLW33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 17:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVCLW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 17:29:29 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:9991 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261207AbVCLW1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 17:27:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Dave Jones <davej@redhat.com>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<20050311021248.GA20697@redhat.com>
	<16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
	<87vf7xg72s.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.58.0503120906020.2398@ppc970.osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Mar 2005 07:26:32 +0900
In-Reply-To: <Pine.LNX.4.58.0503120906020.2398@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 12 Mar 2005 09:09:00 -0800 (PST)")
Message-ID: <877jkcmrfr.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, this should probably check for negative 32-bit values too, ie the 
> test should probably be
>
> 	if ((int)atomic_read(v) <= 0)
>
> and it should probably be done for the regular atomic_dec() etc cases too, 
> not just the dec-and-test. "atomic" values simply aren't historically 
> well-defined for negative values (sparc used to limit them to 24 bits), so 
> a negative thing would always be a bug, I think.

However, inode->i_writecount and some stuffs seems to be already using
the negative values (or sparc was used the signed 24 bits value).

Anyway, unfortunately inode->i_writecount triggered in atomic_dec().

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
