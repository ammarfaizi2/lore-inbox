Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265645AbUALVm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUALVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:42:58 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:55135 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265645AbUALVmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:42:55 -0500
Date: Mon, 12 Jan 2004 13:41:12 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: hch@infradead.org, schwab@suse.de, paulus@samba.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040112134112.2dd0ec42.pj@sgi.com>
In-Reply-To: <20040112000923.GA2743@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040109064619.35c487ec.pj@sgi.com>
	<je1xq9duhc.fsf@sykes.suse.de>
	<20040109152533.A25396@infradead.org>
	<20040109092309.42bb6049.pj@sgi.com>
	<20040112000923.GA2743@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of questions on your proposed patch for __mask_snprintf_len()
in lib/mask.c:

 1) Why make the MASK_CHUNKSZ a possible (compile time) variable?
    I can think of a couple good reasons why not to:
    a] So long as we have the current format, in which each word
       is _not_ zero filled, then the chunk size needs to be a
       well known constant, or else the output is ambiguous.
       For example, an output of "1,0" is ambiguous unless we know
       a priori that the "0" stands for exactly 32, say, bits.
    b] Even if we change to a zero filled format, better to just
       always use the same chunk size, as that is one less detail
       to confuse user level code.
    I don't see any reason offhand for needing code that works with
    more than one chunk size.
 2) Why the trailing "buf[len++] = 0"?  Won't the last snprintf do
    as much?
 3) This code has quite a bit more detail of bit shifts, masks and
    arithmetic than before.  Perhaps some is necessary to fix the
    word order bug I had, perhaps some is only needed to allow for
    the chunk size to vary.  I'll take a shot at seeing if I can
    find a less detail-rich expression of this that still gets the
    word order correct.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
