Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUFMIdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUFMIdX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 04:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbUFMIdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 04:33:23 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:39297 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264895AbUFMIdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 04:33:21 -0400
Date: Sun, 13 Jun 2004 10:33:08 +0200 (CEST)
From: Koblinger Egmont <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: information leak in vga console scrollback buffer
In-Reply-To: <40CBC094.6050901@ThinRope.net>
Message-ID: <Pine.LNX.4.58L0.0406131023260.18435@sziami.cs.bme.hu>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
 <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
 <20040612205903.GA22428@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu>
 <40CBC094.6050901@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2004, Kalin KOZHUHAROV wrote:

> OK, I think I got what you are trying to point out.
> To reproduce:
> 1. login to a (vga) console.
> 2. less /etc/services; press space t oscroll a few screens
> 3. logout
> 4. login again on the same console (possibly as a different user)
> 5. less /etc/resolv.conf
> 6. press UpArrow, then Shift+PgUp
>
> What is expected:
> screen should not scroll past your file.
>
> What happens:
> You can view the previous text (from /etc/services)!!!

Here you didn't clear the scrollback buffer. Maybe you (or getty) executed
a clear or a terminal reset but that only affects the visible part and not
the scrollback buffer. There's absolutely no problem so far since everyone
knows that the scrollback buffer only disappears when you switch to a
different console.

My problem is that with a really-not-trivial-command-and-key-combination
you can possibly see /etc/services (in your example) even _after_ you've
switched to a different console and you are certain that the scrollback
buffer is no longer available.

And then what if it's not /etc/services but some private data of yours?
Maybe other users can later access it. There's no way you can protect
yourself against it. And you live in a false belief that your private data
is scrolled out forever.

Please forget your own test case. Repeat _exactly_ those steps _I_
described in my original post. Then you'll understand what I'm talking
about.

You sure won't understand my problem if you believe that I'm wrong and
want to convience me with your own interpretation of my words and your own
(completely different) test case. Please stick to exactly what I reported.



-- 
Egmont
