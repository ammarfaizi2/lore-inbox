Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUBXXBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUBXXBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:01:23 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:56989 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262524AbUBXXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:01:19 -0500
Subject: Re: cryptoapi highmem bug
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: James Morris <jmorris@intercode.com.au>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040224223425.GA32286@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net>
	 <20040224223425.GA32286@certainkey.com>
Content-Type: text/plain
Message-Id: <1077663682.6493.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 00:01:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 24.02.2004 schrieb Jean-Luc Cooke um 23:34:

> What is calling cbc_process directly?  I don't see how any other function
> could possibly call this function directly.

Nobody is calling it directly.

> cipher.c's cipher() function called cbc_process() with two different src and
> dst buffers, *always*.

It you pass the same to ->encrypt_iv (like kblockd for reads) it will
kmap the same page twice and call cbc_process with two different virtual
addresses pointing to the same page.


