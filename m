Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbRGZLId>; Thu, 26 Jul 2001 07:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbRGZLIN>; Thu, 26 Jul 2001 07:08:13 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:35968 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S266949AbRGZLIE>; Thu, 26 Jul 2001 07:08:04 -0400
Date: Thu, 26 Jul 2001 13:08:09 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726130809.D17244@emma1.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Andrew Morton wrote:

> data=journal
> 
>   All data (as well as to metadata) is written to the journal
>   before it is released to the main fs for writeback.
>   
>   This is a specialised mode - for normal fs usage you're better
>   off using ordered data, which has the same benefits of not corrupting
>   data after crash+recovery.  However for applications which require
>   synchronous operation such as mail spools and synchronously exported
>   NFS servers, this can be a performance win.  I have seen dbench

In ordered and journal mode, are meta data operations, namely creating a
file, rename(), link(), unlink() "synchronous" in the sense that after
the call has returned, the effect of this call is never lost, i. e., if
link(2) has returned and the machine crashes immediately, will the next
recovery ALWAYS recover the link?

Or will ext3 still need chattr +S?

Does it still support chattr +S at all?

Synchronous meta data operations are crucial for mail transfer agents
such as Postfix or qmail. Postfix has up until now been setting
chattr +S /var/spool/postfix, making original (esp. soft-updating) BSD
file systems significantly faster for data (payload) writes in this
directory than ext2.

Note: I'm not on the ext3-users list. Please Cc: back replies.

-- 
Matthias Andree
