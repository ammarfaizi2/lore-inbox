Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUBWWZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUBWWZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:25:14 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22195 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262068AbUBWWYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:24:51 -0500
Date: Mon, 23 Feb 2004 14:24:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223142451.1432ef52.pj@sgi.com>
In-Reply-To: <20040223201340.GA13914@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040223201340.GA13914@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hansjoerg wrote:
> #!/bin/zsh -v -x
> ...
> this should be "evidence" enough(?)

This testing was done on a system with your patch applied, right?
Because on a stock kernel, the various shells are of course
confused by the "-v -x" argv[1].

I will grant that ksh, bash, ash, tcsh and zsh are likely ok
(willing to see > 1 option before the script file name.)

An alternative way to test the same thing, that works even on
a stock kernel:

  $ echo 'echo "$*"' > ./d
  $ ash -e -e ./d 1 2 3
  $ tcsh -v -v ./d 1 2 3
  $ zsh -e -e ./d 1 2 3
  $ ksh -e -e ./d 1 2 3
  $ bash -e -e ./d 1 2 3

The thing being tested: will a shell handle > 1 option before a script
file name.  Each shell invocation of the "./d" script should echo the
script file arguments "1 2 3".

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
