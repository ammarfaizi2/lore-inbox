Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUBYGAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 01:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUBYGAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 01:00:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:32237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262310AbUBYGAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 01:00:20 -0500
Date: Tue, 24 Feb 2004 22:00:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: christophe@saout.de, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-Id: <20040224220030.13160197.akpm@osdl.org>
In-Reply-To: <20040225043209.GA1179@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net>
	<20040224223425.GA32286@certainkey.com>
	<1077663682.6493.1.camel@leto.cs.pocnet.net>
	<20040225043209.GA1179@certainkey.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke <jlcooke@certainkey.com> wrote:
>
> How do I check for equal real addresses from two virtual ones?

I don't think there is a practical way of doing this.  It would involve
comparing the virtual address with the kmap and atomic kmap regions,
performing a pagetable walk, extracting the pageframe.  If the page is not
in a kmap area generate the pageframe directly.  Make that work on all
architectures.  Very yuk.

If practical this API should have been defined in terms of
(page/offset/len) and it should have kmapped the pages itself.  I guess
it's too late for that.

