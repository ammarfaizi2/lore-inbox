Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQKLLZW>; Sun, 12 Nov 2000 06:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbQKLLZM>; Sun, 12 Nov 2000 06:25:12 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:22099
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129029AbQKLLYz>; Sun, 12 Nov 2000 06:24:55 -0500
Date: Sun, 12 Nov 2000 12:17:07 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: john slee <indigoid@higherplane.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, dake@staszic.waw.pl,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 [gus_midi.c breakage]
Message-ID: <20001112121707.B637@jaquet.dk>
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com> <20001112205848.E19275@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001112205848.E19275@higherplane.net>; from indigoid@higherplane.net on Sun, Nov 12, 2000 at 08:58:48PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 08:58:48PM +1100, john slee wrote:
> On Sat, Nov 11, 2000 at 07:22:06PM -0800, Linus Torvalds wrote:
> >-----
> >  - pre3:
> >     - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
> >       cleanups
> 
> this breaks for me, gcc 2.95.2:
> 
> gus_midi.c:206: parse error before `gus_midi_init'
> gus_midi.c:207: warning: return-type defaults to `int'
> gus_midi.c:207: conflicting types for `gus_midi_init'
> gus.h:26: previous declaration of `gus_midi_init'
> gus_midi.c: In function `gus_midi_init':
> gus_midi.c:213: warning: `return' with no value, in function returning non-void
> gus_midi.c:221: warning: `return' with no value, in function returning non-void
> 

The following trivial patch should fix this.


--- linux-240-t11-pre3-clean/drivers/sound/gus_midi.c	Sun Nov 12 09:46:14 2000
+++ linux/drivers/sound/gus_midi.c	Sun Nov 12 12:14:46 2000
@@ -14,6 +14,8 @@
  * 11-10-2000	Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *		Added __init to gus_midi_init()
  */
+
+#include "linux/init.h"
 #include "sound_config.h"
 
 #include "gus.h"


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

``When the president does it, that means that it is not illegal.''
             --Richard M. Nixon, TV interview with David Frost, 1977 May 4
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
