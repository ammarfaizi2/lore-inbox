Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129538AbQKXTU3>; Fri, 24 Nov 2000 14:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129870AbQKXTUT>; Fri, 24 Nov 2000 14:20:19 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5892 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S129538AbQKXTUO>;
        Fri, 24 Nov 2000 14:20:14 -0500
Message-ID: <20001124164812.A2115@bug.ucw.cz>
Date: Fri, 24 Nov 2000 16:48:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: do_initcalls bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

static void __init do_initcalls(void)
{
        initcall_t *call;

        call = &__initcall_start;
        do {
                early_printk("[%lx]\n", call);
                (*call)();
                call++;
        } while (call < &__initcall_end);
}

In case there are no initcalls to be called, it just simply
crashes. Ouch.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
