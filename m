Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUBWOWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUBWOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:22:31 -0500
Received: from mail.shareable.org ([81.29.64.88]:23426 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261871AbUBWOWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:22:21 -0500
Date: Mon, 23 Feb 2004 14:22:15 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jackson <pj@sgi.com>
Cc: hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223142215.GB30321@mail.shareable.org>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222214457.6f8d2224.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> > I believe the question was "which shell expects the name in argv[2]
> 
> The question is more like: examine each shell's argument parsing code to
> determine which ones will or will not be affected by this.  For a change
> like this, someone needs to actually look at the code for each major
> shell, and verify their reading of the code with a little experimentation.

Eh?  We do know what the major shells do: They either look at the
first non-option argument for the script name, or they do not accept
options at all.

Anyway that's irrelevant: the splitting change only affects shell
_scripts_ which already have multiple options on the #! line, and
which depend on a space not splitting the argument.  If a script
doesn't have that, the shell's behaviour isn't affected by this
change.

Such scripts are non-portable because that behaviour isn't universal
(although I have a feeling the current Linux behaviour was done to
mimick some existing system - as it was never hard to implement
argument splitting of the original author had wanted to.)

In other words, what's relevant is which shell _scripts_ would be
affected, not which shells.

To find those scripts, do:

    find /bin /sbin /usr/bin /usr/sbin /usr/X11R6/bin /usr/local/bin \
         /etc /usr/lib -type f \
    | xargs perl -ne 'print "$ARGV\n" if /^#! ?.+ .+ /; close ARGV'

(Or choose your own directories).

I didn't find any on my system.

-- Jamie
