Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUJRXFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUJRXFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUJRXFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:05:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29353 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267725AbUJRXFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:05:05 -0400
Date: Mon, 18 Oct 2004 19:04:50 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Oleg Makarenko <mole@quadra.ru>
cc: Matt Domsch <Matt_Domsch@dell.com>, <davem@davemloft.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
In-Reply-To: <41742215.8020005@quadra.ru>
Message-ID: <Xine.LNX.4.44.0410181859030.25082-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, Oleg Makarenko wrote:

> And one more question on crypto api. It looks like it is not very 
> effective for a single byte "block" ciphers as arc4. The overhead is 
> probably too big. Just look at the loop in cipher.c/crypt() and the code 
> in arc4.c/arc4_crypt(). All this code is called for every single clear 
> text byte. Right? Looks like an overkill for bsize == 1.
> 
> Is there any better way to use crypto api for arc4 or similar ciphers? 
> Cipher block size is not always a natural choice for the crypto_yield(). 
> Especially for fast ciphers (arc4) and small "block" sizes (arc4 again).

ARC4 is a bit strange because it's a stream cipher.  I guess we could add 
another encryption mode 'stream' which is optimized for one byte at a time 
operation.


- James
-- 
James Morris
<jmorris@redhat.com>


