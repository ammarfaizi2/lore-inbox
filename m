Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSFPROL>; Sun, 16 Jun 2002 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSFPROK>; Sun, 16 Jun 2002 13:14:10 -0400
Received: from fungus.teststation.com ([212.32.186.211]:39442 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316423AbSFPROK>; Sun, 16 Jun 2002 13:14:10 -0400
Date: Sun, 16 Jun 2002 19:13:03 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Erik McKee <camhanaich99@yahoo.com>
cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [ERROR][PATCH] smbfs compilation in 2.5.21
In-Reply-To: <20020616162402.32079.qmail@web14201.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0206161831390.6294-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Erik McKee wrote:

> THis is from the bk tree.  It's gcc 2.95.3.  That solution might be a bettr one
> after all ;)  However, would the stringifying done here to get the function
> name in there mess that up?

stringifying?

The whole point of the original change was to not do any string
concatenation of __FUNCTION__, but it is a string already.


However, could you try this change instead:

-# define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ## a)
+# define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ## a)

Apparently an extra space before the comma before ## is supposed to
matter. Several of the macros I pointed at before already do that.

See also
http://gcc.gnu.org/onlinedocs/gcc-3.1/cpp/Variadic-Macros.html

/Urban

