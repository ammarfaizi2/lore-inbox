Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267020AbTGGORg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 10:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267033AbTGGORg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 10:17:36 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:28857 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S267020AbTGGORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 10:17:31 -0400
From: Daniel Phillips <phillips@arcor.de>
To: alexander.riesen@synopsys.COM
Subject: Re: 2.5.74-mm1
Date: Mon, 7 Jul 2003 16:33:15 +0200
User-Agent: KMail/1.5.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307071424.06393.phillips@arcor.de> <20030707130905.GA13611@Synopsys.COM>
In-Reply-To: <20030707130905.GA13611@Synopsys.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071633.15752.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 15:09, Alex Riesen wrote:
> Daniel Phillips, Mon, Jul 07, 2003 14:24:06 +0200:
> > In retrospect, the idea of renicing all the applications but the
> > realtime one  doesn't work, because it doesn't take care of
> > applications started afterwards.
>
> start login niced to -X ?

Actually, the opposite: start login niced to +X (x ~= 5).  This is a tidy way 
of providing the user with the needed manuevering room on the not-nice side, 
and is guaranteed not to interfere with root processes.  All logins on that 
machine would have to start with that same positive niceness, including for 
example, ssh logins.  The correct place to centralize this is the login 
program, I think, perhaps by making it aware of some environment variable or 
some setting in /etc.

To work well, this strategy has to be coupled with a scheduler guarantee that 
no priority level can completely starve any lower priority.  At this point, I 
don't know where we stand in that regard.

Regards,

Daniel

