Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbQLPXqr>; Sat, 16 Dec 2000 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbQLPXqh>; Sat, 16 Dec 2000 18:46:37 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:24846 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130781AbQLPXq1>;
	Sat, 16 Dec 2000 18:46:27 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: dwmw2@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: Your message of "Sat, 16 Dec 2000 23:07:01 BST."
             <20001216230701.E609@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 10:15:53 +1100
Message-ID: <27504.977008553@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000 23:07:01 +0100, 
Rasmus Andersen <rasmus@jaquet.dk> wrote:
>Various files in drivers/mtd references cfi_probe (by way of do_cfi_probe).
>This function is static and thus not shared. The following patch removes
>the static declaration but if it is What Was Intended I do not know. It
>makes the kernel link, however.

Somebody changed include/linux/mtd/map.h between 2.4.0-test11 and
test12.  That change is wrong, it adds conditional complexity where it
is not required - inter_module_xxx works even without CONFIG_MODULES.
cfi_probe should still be static.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
