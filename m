Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288768AbSANFJG>; Mon, 14 Jan 2002 00:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288778AbSANFI5>; Mon, 14 Jan 2002 00:08:57 -0500
Received: from zok.SGI.COM ([204.94.215.101]:61571 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288768AbSANFIq>;
	Mon, 14 Jan 2002 00:08:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: drivers missing __devexit_p in 2.4.18pre3 
In-Reply-To: Your message of "Sun, 13 Jan 2002 20:07:34 PDT."
             <20020114030734.GB17592@codepoet.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jan 2002 16:08:25 +1100
Message-ID: <25155.1010984905@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 20:07:34 -0700, 
Erik Andersen <andersen@codepoet.org> wrote:
>A quick check of the source code shows that the following drivers
>appear to still be lacking the devinit fixes which are needed for
>the kernel to compile when using newer versions of binutils.
>
>Each of these files probably needs the following (though I'm too
>lazy to do it all myself, since my kernel doesn't use any of this
>stuff):
>
>	s/remove:\(.*\)/remove:__devexit_p(\1)/g

Don't do that.  You are blindly converting all remove entries to use
__devexit_p but __devexit_p should only be used when the function
itself is declared as __devexit.

I went through the entire kernel looking for uses of __devexit and
manually checked each reference to those functions, changing only the
functions that used __devexit.  I might have missed one or two but I
guarantee that your list is wrong, picking three files at random, none
of them use __devexit.

