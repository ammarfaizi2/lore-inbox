Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUBVKHp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUBVKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:07:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:46239 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261217AbUBVKHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:07:43 -0500
Date: Sun, 22 Feb 2004 02:09:11 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org, hjlipp@web.de
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040222020911.2c8ea5c6.pj@sgi.com>
In-Reply-To: <20040216133418.GA4399@hobbes>
References: <20040216133418.GA4399@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the incompatible changes you note:
  1) "#! cmd x y" to pass single arg "x y" with embedded space broken
  2) Use of '\' char changed
  3) Handling of long line changed
doesn't this also
  4) risk breaking shells that look to argv[2] for the name of the
    shell script file for error messages?  This argument
    has moved out to argv[argc-1], for some value of argc.

I'll wager you have to make a better case for this than simply:

    As I'm really missing this feature in Linux and changing this
    would not break any (unless ...

before the above incompatibilities in a critical piece of code are
overcome with the compelling need to change these details.

Perhaps you can handle any such special argument specification by
wrapping the user level command, as in:

Instead of:

    #!/usr/bin/awk -F \t -f
    ... my awk code ...

rather do:

    #!myawk
    ... my awk code ...

where myawk is a compiled program that essentially does

    /usr/bin/awk -F '\t' -f argv[2]

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
