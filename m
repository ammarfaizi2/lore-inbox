Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWFRG3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWFRG3d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFRG3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:29:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:2545 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751103AbWFRG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:29:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kg49rN6WXoW7f4ejDd7BLWgWYysCdoQ73NsyuOvBjJ0RBCqw4NKXRbAx8dO+e8V2WOfu6BLVDYSFThEYwRQlx8g16vrJg6BXVMlLB7UkBy+8Qq+k5r6WtUl9IcCpGg/82f43ELegovgRQ6OpQrM8k8hA1jQiOh4nBTgsdaHNWsE=
Message-ID: <21d7e9970606172329w4a152a1el64e676259c2a759c@mail.gmail.com>
Date: Sun, 18 Jun 2006 16:29:32 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
Subject: [git pull] intelfb tree for 2.6.18
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "Sylvain Meyer" <sylvain.meyer@worldonline.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
       Can you pull the 'i915fb' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6.git

This adds support for the i915 and i945 chipsets to the intelfb driver
for CRT modesetting.
The tree has been in -mm for a while and I've tested it on i865 and
i915, and Antonino is happy  with it.

Regards,
Dave.

 drivers/video/Kconfig              |    2
 drivers/video/intelfb/intelfb.h    |   16 +
 drivers/video/intelfb/intelfbdrv.c |   85 +++++-
 drivers/video/intelfb/intelfbhw.c  |  494 ++++++++++++++++++++++++------------
 drivers/video/intelfb/intelfbhw.h  |   25 --
 5 files changed, 412 insertions(+), 210 deletions(-)

commit 2abac1db3522d9f56c695d1b42e77f3e52d4c51a
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Jun 18 16:12:27 2006 +1000

    intelfb: fixup clock calculation debugging.

    The debugging code for pll clocks was wrong and causing div by 0.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 72109368de7aaa5d489d9ca4641f4a11a6fc7653
Author: Dennis Munsie <dmunsie@cecropia.com>
Date:   Wed Jun 7 18:53:38 2006 +1000

    Removed hard coded EDID buffer size.

    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
    Acked-by: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 7a532c69c37dbb46bfd0276160e624f06552adfc
Author: Dennis Munsie <dmunsie@cecropia.com>
Date:   Mon May 29 18:58:09 2006 +1000

    intelfb: use regular modedb table instead of VESA

    intelfb driver -- use the regular modedb table instead of the VESA modedb
    table.  Ideally, the 9xx stride patch should be applied first, since there
    are modes in the VESA table that won't work without that patch.

    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 56e004e5435c008728b1444b51d757da2e098976
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Mon May 29 18:49:08 2006 +1000

    intelfb: use firmware EDID for mode database

    Use firmware EDID for the driver's private mode database.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
    Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 080a416802153dbbb20ab4f4fa1225867096d071
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon May 29 18:45:19 2006 +1000

    Revert "intelfb driver -- use the regular modedb table instead of the VESA"

    This reverts 2c47430a03bbcc3c9a623a07eca5baf92c7d20c8 commit.
    This conflicts with a patch in -mm from Antonino reapply later.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 65eb2f97db17f6f6a92cad3aad93b531f991ebf1
Author: Eric Hustvedt <ehustvedt@cecropia.com>
Date:   Mon May 29 18:38:55 2006 +1000

    intelfb: int option fix

    Fix integer option parsing in the intelfb driver. The macro wasn't
    accounting for the equal sign past the option name. As a result,
    the vram option always returned 0.

    Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f728377f6786bcdf1dbf33394360164e86f40094
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat May 27 18:56:02 2006 +1000

    sync modesetting code with X.org

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit c9daa873c3a7c769821ec6c8258adf098bb0435c
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat May 27 18:44:02 2006 +1000

    intelfb: align with changes from my X driver.

    This just realigns the PLL calculation routines with the ones from my X.org
    driver.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2c47430a03bbcc3c9a623a07eca5baf92c7d20c8
Author: Dennis Munsie <dmunsie@cecropia.com>
Date:   Sat May 27 18:33:35 2006 +1000

    intelfb driver -- use the regular modedb table instead of the VESA
    modedb table.  Ideally, the 9xx stride patch should be applied first, since
    there are modes in the VESA table that won't work without that patch.

    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 1aecb393091d3c0787f92445420d96ef58c9782a
Author: Eric Hustvedt <ehustvedt@cecropia.com>
Date:   Sat May 27 18:30:00 2006 +1000

    Adds support for 256MB aperture on 945 chipsets to the intelfb driver
    and corrects calculation of stolen memory overhead.

    Signed-off-by: Eric Hustvedt <ehustvedt@cecropia.com>
    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit df7df8ab7b38ca80bbaf5ffafd401d6c739fd45f
Author: Dennis Munsie <dmunsie@cecropia.com>
Date:   Sat May 27 18:17:52 2006 +1000

    intelfb -- uses stride alignment of 64 on the 9xx chipsets.

    Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 51d797474f87b375819d084f7583a2864c5656c4
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Apr 3 16:19:26 2006 +1000

    intelfb: some cleanups for intelfbhw

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 3587c50991b96fee2d26942f380e36e4f40fad71
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Apr 3 14:46:55 2006 +1000

    intelfb: fixup pitch calculation like X does

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 3aff13cfb8810cc228e8fdcb92103ed0b11ee38e
Author: Dave Airlie <airlied@linux.ie>
Date:   Fri Mar 31 17:08:52 2006 +1000

    intelfb: fixup p calculation

    This fixes up the p calculation of p1 and p2 for the i9xx chipsets.
    This seems to work a lot better for lower pixel clocks..

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 46f60b8e67e6fceede851dc69cdee2d7c0de27b9
Author: Dave Airlie <airlied@linux.ie>
Date:   Fri Mar 24 12:31:14 2006 +1100

    This patch makes a needlessly global struct static.

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 9a90603f65dd5046ddcd586158abcad7784892b6
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 21:53:05 2006 +1100

    intelfb: add i945GM support

    Untested i945GM support just add the framework.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8b91b0b4f2d731b92f59bc82492769a09b4955a6
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 19:23:48 2006 +1100

    intelfb: fixup whitespace..

    repeat after me, I must not take code from X without reformatting...

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8bb91f6a2d1db8031bfbb367df075f041d0cdfe2
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 13:06:32 2006 +1100

    intelfb: add hw cursor support for i9xx

    This adds hw cursor support for the i9xx chipsets.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 7679f4d69296de97a7f62458cc4d1c6c884dfcfb
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 12:30:05 2006 +1100

    intelfb: make i915 modeset

    This takes the modeset and pll code from my X driver.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 9639d5ec07a490134f05ac890506a367aaf8663b
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 11:23:55 2006 +1100

    intelfb: add support for i945G

    This just adds the defines and structure for i945G

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 0c187addabbaf93512902442b4a90140a21b0ddc
Author: Dave Airlie <airlied@linux.ie>
Date:   Thu Mar 23 11:20:08 2006 +1100

    intelfb: enable on x86_64

    i945G chipsets supports 64-bit.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 16109b3f4c1f2635afd32eb6d49348590de2cb25
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Mar 20 21:22:09 2006 +1100

    intelfb: add p divisor increments for i9xx.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 8492f081e5552ff388068f612eae6f55f7210ed4
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Mar 20 20:54:12 2006 +1100

    intelfb: change splitm to be brute force

    The old splitm didn't always work use a brute force.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d024960cff5173bef6e83c01cf9cd2763c2c0ab0
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Mar 20 20:26:45 2006 +1100

    intelfb: add pll index to the intelfb structure

    Add the pll index into the information structure, change get_chipset to
    take only the info structure, use plls in correct places

commit 7258b11d2e9a47d2b01620622579f22906960e1a
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Mar 20 20:02:24 2006 +1100

    intelfb: prepare for i9xx support.

    This code just moves the PLL min/max calculations variables into
    a structure, it doesn't change or add any new functionality.

    Signed-off-by: Dave Airlie <airlied@linux.ie>
