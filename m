Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbRARSiA>; Thu, 18 Jan 2001 13:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRARSht>; Thu, 18 Jan 2001 13:37:49 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:33499 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S130462AbRARShm>; Thu, 18 Jan 2001 13:37:42 -0500
Message-ID: <3A6737EF.C655ECCC@inet.com>
Date: Thu, 18 Jan 2001 12:37:35 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, eli.carter@inet.com, alan@redhat.com
Subject: Re: [PATCH] pcnet32.c ARM support & AM79C973 improvements
In-Reply-To: <3A671DD5.51B4DEE@inet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> Here is a patch that adds the following to the pcnet32.c driver:
[snip]
> - According to the Am79C973/Am79C975 docs from AMD, The collision bits
> are only valid if ENP is set, so I added a check for that.
[snip]
> @@ -1164,7 +1206,8 @@
>                     }
>  #endif
>                 } else {
> -                   if (status & 0x1800)
> +                   /* MORE and ONE are only valid if ENP is set */
> +                   if (status & 0x0040 && status & 0x1800)
>                         lp->stats.collisions++;
>                     lp->stats.tx_packets++;
>                 }

Argh.   That should read
+                   if (status & (1<<8) && status & 0x1800)
I'm tempted to change some of these magical numbers into #defines...
That would make it a bit easier to read, but have no functional
changes--would such a patch be accepted into the various trees?

Just my two bits.  ;)

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
