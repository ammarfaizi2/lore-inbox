Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbVCEAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbVCEAUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbVCEARB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:17:01 -0500
Received: from manson.clss.net ([65.211.158.2]:7406 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S263066AbVCDXdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:33:45 -0500
Message-ID: <20050304233321.4882.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: SVGATextMode on 2.6.11
To: linux-kernel@vger.kernel.org
Date: Fri, 4 Mar 2005 18:33:21 -0500 (EST)
In-Reply-To: <no.id> from "Alan Curry" at Mar 02, 2005 05:38:59 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>
>Was SVGATextMode's cursor-setting ability removed as a result of an
>intentional change, or might it get fixed? Or might CUR_DEFAULT become
>tunable? Maybe another control sequence could make the current cursor
>settings the default, like setterm -store does for foreground and background
>colors.

I found the cause of this new behavior: font loading. SVGATextMode can be
configured to load a font with consolechars. It does that after setting the
cursor. In 2.6.11 vgacon_adjust_height() was changed to reset the cursor in
addition to the font size. The solution is: disable SVGATextMode's font
loading, and if you want to change the font, do it before you run SVGATextMode.

The second problem remains a mystery:

>On another note, the resize function of SVGATextMode has been affected
>strangely too. Sometimes, when resizing the screen to a mode larger than
>80x25, the video settings come out correctly but the terminal only uses the
>first 25 lines, with the bottom of the screen being blank. This one is hard
>to reproduce. I can reproduce it by doing a full boot (which includes an
>SVGATextMode call from /etc/rcS.d/S60svgatextmode) followed by a manual
>SVGATextMode on tty2. The first one works, and the second one screws up the
>terminal size. When I try to reproduce that series of events without the call
>from /etc/rcS.d, the problem doesn't show up.
>
>In any case, when that problem _does_ show up, it can be fixed by immediately
>running the same command again, on the same tty where it just screwed up. And
>it never fails twice without an intervening reboot.
