Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbRA2Lws>; Mon, 29 Jan 2001 06:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbRA2Lw3>; Mon, 29 Jan 2001 06:52:29 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:18182 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S130330AbRA2LwS>; Mon, 29 Jan 2001 06:52:18 -0500
Message-ID: <3A755950.9C730B80@psychosis.com>
Date: Mon, 29 Jan 2001 06:51:44 -0500
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
Organization: www.psychosis.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1p11-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Remove arbitrary md= boot device limit
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.1p11-1/drivers/md/md.c
line 3643
-#define MAX_MD_BOOT_DEVS     8
+#define MAX_MD_BOOT_DEVS     MAX_MD_DEVS

-------------------------------------------------------
To:  Dave Cinege <dcinege@psychosis.com>

On Mon, 29 Jan 2001, Dave Cinege wrote:

> -#define MAX_MD_BOOT_DEVS     8
> +#define MAX_MD_BOOT_DEVS     MAX_MD_DEVS

sure this is fine.

        Ingo
-------------------------------------------------------
To:	Ingo Molnar <mingo@redhat.com>

Devices above md8 will not be initialized when speced with md=.
Error ("md: Minor device number too high.\n");

The limitation is imposed by
        #define MAX_MD_BOOT_DEVS        8
However it appears arbitray to me. Doesn't make much sence since you can create
/dev/md100 and it may well be the only md device you have...

Is there any reason the next 2.4.1 prepatch should not include this?

-#define MAX_MD_BOOT_DEVS       8
+#define MAX_MD_BOOT_DEVS       MAX_MD_DEVS

(If not I assume you will be submitting this to Linus...)

-- 
"Nobody will ever be safe until the last cop is dead."
		NH Rep. Tom Alciere - (My new Hero)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
