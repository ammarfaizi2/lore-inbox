Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTD1CaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTD1CaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:30:04 -0400
Received: from almesberger.net ([63.105.73.239]:2579 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263336AbTD1CaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:30:03 -0400
Date: Sun, 27 Apr 2003 23:42:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Mark Grosberg <mark@nolab.conman.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030427234215.D16041@almesberger.net>
References: <Pine.LNX.4.53.0304272203570.14901@chaos> <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>; from mark@nolab.conman.org on Sun, Apr 27, 2003 at 10:12:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Grosberg wrote:
>    fmap[0] = in[0];                     /* STDIN  */
>    fmap[1] = out[1];                    /* STDOUT */
>    fmap[2] = open("/dev/null", O_RDWR); /* STDERR */
>    fmap[3] = -1;                        /* end    */
> 
>    p = nexec("/bin/cat",
>              null_argv,
>              NULL,
>              filmap);

How about

    fdrplc(3,fmap);
    exec("/bin/cat",...);

?

0) System call names must be short and cryptic :-)
1) Requiring the kernel to iterate over the array element by element
   in order to find out how big it is may be inefficient. Better to
   pass the length.
2) System call overhead is marginal, particularly in this case.
3) There may be other uses than exec(2), where a way for closeing
   all fds and getting a new set may be useful.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
