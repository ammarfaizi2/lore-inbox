Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSICUxK>; Tue, 3 Sep 2002 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318924AbSICUxK>; Tue, 3 Sep 2002 16:53:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:52170 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318923AbSICUxH>;
	Tue, 3 Sep 2002 16:53:07 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15733.8764.96293.719729@harpo.it.uu.se>
Date: Tue, 3 Sep 2002 22:57:32 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > Ok,
 >  I found another major bio-related bug that definitely explains why the 
 > floppy driver generated corruption - any partial request completion would 
 > be totally messed up by the BIO layer (not the floppy driver).
 > 
 > Any other block device driver that did partial request completion might 
 > also be impacted.
 > 
 > I'm still looking at the floppy driver itself - some of the request 
 > completion code is so messed up as to be unreadable, and some of that may 
 > actually be due to trying to work around the bio problem (unsuccessfully, 
 > I may add). So this may not actually fix things for you yet, simply 
 > because the floppy driver itself still does some strange things. 

Confirmed. 2.5.33 + your two patches still corrupts data on a simple
dd to then from /dev/fd0 test.

/Mikael
