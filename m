Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUJWDpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUJWDpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJVTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:38:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24290 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267251AbUJVThf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:37:35 -0400
Subject: Re: [PATCH] Shift key-related error codes up and insert ECANCELED
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20498.1098464262@redhat.com>
References: <20498.1098464262@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098470076.19458.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 19:34:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 17:57, David Howells wrote:
> This patch shifts the key-related error codes up by one and inserts an
> ECANCELED error code where not already defined. It seems that has been defined
> in glibc without passing it back to the kernel:-/
> 
> Who arbitrates error number allocations anyway?

Generally nobody because new error codes are almost always a mistake in
the first place especially when they don't appear in standards so no
application will correctly or sanely handle them.

You should use existing codes IMHO. Lets see

EKEYEXPIRED		-	ETIME (ETIMEDOUT ? ENOLINK ?)
ENOKEY			-	ENOENT
EKEYREJECTED		-	EILSEQ / EMSGSIZE / EPROTOTYPE ..
EKEYREVOKED		-	EREMCHG / ESHUTDOWN

And now I can use your key stuff with an existing C library and in LSB
compliant or cross platform code and give more information. If you look
through the kernel history we've almost never ever added an error code,
adding them just causes compatibility pain for everyone


Alan

