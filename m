Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQKFAsR>; Sun, 5 Nov 2000 19:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129195AbQKFAsH>; Sun, 5 Nov 2000 19:48:07 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:42531 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129110AbQKFAr6>; Sun, 5 Nov 2000 19:47:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10) 
In-Reply-To: Your message of "Sun, 05 Nov 2000 23:15:27 -0000."
             <Pine.LNX.4.21.0011052257130.6733-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 11:47:30 +1100
Message-ID: <1992.973471650@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000 23:15:27 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>Your patch looks like it'll work. Although I don't really see any
>advantage over {get,put}_module_symbol() in this case, it does look like
>it can be used to finally provide module persistent storage, which will be
>useful.

Cleanliness.  All other module data flows go via explicit symbols which
are fixed up at link time or via registration functions.  Having a few
sources that use a third mechanism which forces people to use
EXPORT_SYMBOL_NOVERS() to make it work is messy and redundant.

I'm not sure why you think this can be used for module persistent
storage.  If a module calls inter_module_register() on load, it should
call inter_module_unregister() on unload.  All the registered data
points into the loaded module, remove the module and the storage
disappears as well.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
