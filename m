Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262261AbSJARMc>; Tue, 1 Oct 2002 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbSJARKq>; Tue, 1 Oct 2002 13:10:46 -0400
Received: from mnh-1-06.mv.com ([207.22.10.38]:23301 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262254AbSJARKf>;
	Tue, 1 Oct 2002 13:10:35 -0400
Message-Id: <200210011819.NAA02853@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Oleg Drokin <green@namesys.com>
cc: James Stevenson <james@stev.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.5.39 
In-Reply-To: Your message of "Tue, 01 Oct 2002 11:44:54 +0400."
             <20021001114454.A27039@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Oct 2002 13:19:36 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

green@namesys.com said:
> Here's what I need to apply before I can build bk-current with UML
> support. 

Applied, thanks.

> And then kernel mode fault at 0x5a5a5a5e 

Can you get a stack trace from that crash?

> Just before the crash it warns about winch_interrupt : read failed,
> errno = 9 fd 57 is losing SIGWINCH support 

This looks different.  Is it consistently the same file descriptor?  If so,
put a breakpoint on close and see who's closing it who isn't supposed to.

> @@ -863,6 +863,7 @@
>  			return(-EFAULT);
>  		return(0);
>  	}
> +	return -ENOTTY;
>  }

I did a check of some of the other block drivers, and they mostly seem to
do -EINVAL rather than -ENOTTY.  There was an oddball -ENOSYS, but I guess
I'll stick with -EINVAL.

				Jeff

