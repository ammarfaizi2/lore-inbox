Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbSLFWx7>; Fri, 6 Dec 2002 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbSLFWx7>; Fri, 6 Dec 2002 17:53:59 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:38158 "EHLO
	basket.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S267655AbSLFWx4>; Fri, 6 Dec 2002 17:53:56 -0500
Date: Fri, 6 Dec 2002 23:59:40 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <15835232027.20021206235940@uni.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re[2]: [STATUS] fbdev api.
In-Reply-To: <1039218931.989.24.camel@localhost.localdomain>
References: <6723376646.20021206204207@uni.de>
 <1039218931.989.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Antonino,

Saturday, December 7, 2002, 12:55:34 AM, you wrote:

>> a) Although your patch fixes the FB oddness for me, it makes booting
>>    without using framebuffer fail, IOW the kernel hangs:
>> 
>>    Video mode to be used for restore is f00
>>    BIOS-provided physical RAM map:
>>     BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>> 
AD> Do you have framebuffer console enabled but with no framebuffer device
AD> enabled at boot time?  This will always fail with James' current patch.

AD> The diff I submitted in one of my replies in this thread (fbcon.diff)
AD> might fix that (not sure).

Thanks, that patches fixes it.


>> b) After returning from blanking mode (via APM) to normal mode, no
>>    character is drawn. Let's assume I'm using VIM when that happens:
>>    After putting any character to return from blank mode, the screen stays
>>    blanked apart from the cursor that _is_ shown. Now I'm able to move
>>    the cursor, and when the cursor encounters a character, this char
>>    is drawn (and keeps drawn). Though when I press Ctrl-L or when I go one line
>>    above to the current top-line (i.e. by forcing a redrawn), the
>>    whole screen is drawn properly.
>> 
AD> Can you try this?
AD> [..diff..]

Yes, it fixes the problem, thanks.


>> c) instruction:          | produces:
>>    ======================|==================
>>    1. typing abc def     | $ abc def
>>                          |          ^ (<- cursor)
>>    2. going three chars  | $ abc def
>>       ro the left        |       ^
>>    3. pressing backspace | $ abcddef
>>                          |      ^
>>    4. pressing enter     | -bash: abcdef: command not found
>>                          |

AD> I get this also. Seems to occur only with colored terms.  When I do 

AD> set TERM=vt100

AD> the problem disappears, so I thought this was an isolated case with my
AD> setup :-). Similar glitches happen also in emacs with syntax
AD> highlighting turned on.

Still there.


AD> Tony
-- 
cheers,
 Tobias

