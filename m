Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSLFTgX>; Fri, 6 Dec 2002 14:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLFTgW>; Fri, 6 Dec 2002 14:36:22 -0500
Received: from snow.ball.teaser.net ([213.91.6.13]:7684 "EHLO
	snow.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S265650AbSLFTgW>; Fri, 6 Dec 2002 14:36:22 -0500
Date: Fri, 6 Dec 2002 20:42:07 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <6723376646.20021206204207@uni.de>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

Monday, December 2, 2002, 10:07:33 PM, you wrote:

JS> Hi!

JS> I have a new patch avaiable. It is against 2.5.50. The patch is at
JS> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Besides the hunks posted recently, I encountered three problems/bugs:

a) Although your patch fixes the FB oddness for me, it makes booting
   without using framebuffer fail, IOW the kernel hangs:

   Video mode to be used for restore is f00
   BIOS-provided physical RAM map:
    BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)

b) After returning from blanking mode (via APM) to normal mode, no
   character is drawn. Let's assume I'm using VIM when that happens:
   After putting any character to return from blank mode, the screen stays
   blanked apart from the cursor that _is_ shown. Now I'm able to move
   the cursor, and when the cursor encounters a character, this char
   is drawn (and keeps drawn). Though when I press Ctrl-L or when I go one line
   above to the current top-line (i.e. by forcing a redrawn), the
   whole screen is drawn properly.

c) instruction:          | produces:
   ======================|==================
   1. typing abc def     | $ abc def
                         |          ^ (<- cursor)
   2. going three chars  | $ abc def
      ro the left        |       ^
   3. pressing backspace | $ abcddef
                         |      ^
   4. pressing enter     | -bash: abcdef: command not found
                         |

HTH.
--
cheers,
 Tobias

