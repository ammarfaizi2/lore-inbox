Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTDXSsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTDXSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:48:36 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57357 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263429AbTDXSse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:48:34 -0400
Date: Thu, 24 Apr 2003 21:02:48 +0200
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange behavior in out-of-memory situation
Message-ID: <20030424190248.GA2766@hh.idb.hist.no>
References: <3EA83396.4040904@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA83396.4040904@techsource.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 02:57:26PM -0400, Timothy Miller wrote:
> I'm using Red Hat kernel 2.4.18-26.7.x.
> 
> I ran a program which is trying to suck up all of memory.  I would like 
> to kill the process, but "top", "vmstat", and "ps" all hang when I try 
> to use them.  Also, pressing ctrl-c in the terminal where I can the 
> program won't kill it.
> 
> To an extent, however, the system was still usable, albeit EXTREMELY 
> unresponsive.  Eventually, the program dumped core, and everything 
> returned to norma.
> 
> Is this a known problem?

Your system seems to be in normal working order. There is no problem here.
A program using up all memory _will_ make the machine very unresponsive
as everything goes into swap (or discards all executable code for
those who think they can fool the system by not having swap).

You may indeed be unable to run other programs like top, because
there aren't enough memory left to run them.  Your program probably
dumped core when it ran the system completely out of memory and
trigged the Out-Of-Memory killer.

The only unusual here is that ctrl+c didn't work, but some
programs block that signal. Perhaps your program does too.

You can use ulimit if you don't want your machine to become
sluggish.  The effect is that your memory eater will be killed
earlier, before it uses up so much memory that nothing else
will run.

Helge Hafting

