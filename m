Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTD1GXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 02:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTD1GXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 02:23:37 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:43156 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S263499AbTD1GXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 02:23:36 -0400
Date: Mon, 28 Apr 2003 02:35:52 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <20030427234215.D16041@almesberger.net>
Message-ID: <Pine.BSO.4.44.0304280232050.31738-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, Werner Almesberger wrote:

> How about
>
>     fdrplc(3,fmap);
>     exec("/bin/cat",...);

Not a bad idea. Although my initial motives were to try and reduce the
number of syscalls for forking processes, I can see this as kind of a
useful call as well.

> 0) System call names must be short and cryptic :-)

Heh. How about something like fdmap_set()?

> 1) Requiring the kernel to iterate over the array element by element
>    in order to find out how big it is may be inefficient. Better to
>    pass the length.

Good point. Just a quick verify_area() check and then process away.

> 2) System call overhead is marginal, particularly in this case.

Depends. I know that on the one multi-user Linux machine I do use on a
day-to-day basis syscall overhead is painful:

  Calibrating delay loop.. ok - 16.59 BogoMIPS

and considering this is a multi-user machine with quite a few users always
tapping away doing quick commands (edit this file, run this program, copy
this file, ...).

> 3) There may be other uses than exec(2), where a way for closeing
>    all fds and getting a new set may be useful.

Agreed.

L8r,
Mark G.


