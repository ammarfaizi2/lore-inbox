Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUKICiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUKICiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKICiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:38:21 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:58515 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261349AbUKICiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:38:07 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [Linux-fbdev-devel] cursor bug
Date: Tue, 9 Nov 2004 10:37:50 +0800
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041108161113.GA23504@bytesex>
In-Reply-To: <20041108161113.GA23504@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091037.52418.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 00:11, Gerd Knorr wrote:
>   Hi,
>
> There is annonying cursor bug in recent kernels (started in 2.6.10-rc1
> IIRC).  There kernel seems not to keep track of the cursor state
> correctly when switching virtual terminals.  Here is how to reproduce
> it:
>
>   (1) boot with vesafb (thats what I'm using, maybe it shows on other
>       framebuffers and/or vgacon as well).
>   (2) login into one terminal, then type "echo -ne '\033[?17;15;239c'".
>       You should have a nice, yellow and *not* blinking cursor block.
>       That is what I have in my .profile because I can't stand the
>       blinking cursors.
>   (3) Switch to another terminal.  The cursor goes into blinking
>       underscore mode now (i.e. the default cursor).
>   (4) Switch back to the first terminal.  Now you have a yellow block
>       with the last two pixel lines (i.e. the underscore) blinking.
>
> Oh no.  Please fix that.  Thank you.

Hmn, this bug has been present since the beginning of 2.6, probably even
2.5, hidden, but got exposed during the cursor cleanup.  The main problem is
that fbcon is not checking if the vt is using its own softcursor, and this
has been the case since the fb architecture was rewritten. 

We fix this by checking if vt.c is using its softcursor
(vc->vc_cursor_type & 0x10), and if true, disable fbcon cursor.

I'll submit a patch to Andrew.

Tony


