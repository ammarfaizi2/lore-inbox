Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTEGGho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbTEGGho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:37:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262918AbTEGGhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:37:43 -0400
Date: Tue, 06 May 2003 22:42:39 -0700 (PDT)
Message-Id: <20030506.224239.15246035.davem@redhat.com>
To: hch@infradead.org
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507074111.A9109@infradead.org>
References: <20030507072830.A7586@infradead.org>
	<20030506.222729.35034981.davem@redhat.com>
	<20030507074111.A9109@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Wed, 7 May 2003 07:41:11 +0100
   
   If we have kernel declaration in those ABI headers you'd need an
   updated abi-headers package for each change in one of your
   prototypes, rendering it almost useless.
   
This reminds me about why this topic is actually a sticky area.

The main argument goes like this, I compile glibc against kernel
headers FOO therefore it is illegal to update headers that user apps
could see (without rebuilding GLIBC against them first) because this
could indirectly change glibc "stuff".

   For this to work you really need two classes of headers, one the defines
   ABIs and only ABIs and one that's for all kernel internal stuff.
   
I agree that this kind of splitup is desirable.  As I mentioned,
things like {linux,net}/xfrm.h are probably the best model.

Thanks for reminding me about this, I'll start to split rtnetlink.h
and friends up.
