Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUBWUQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUBWUQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:16:29 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:11586 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262017AbUBWUQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:16:19 -0500
Date: Mon, 23 Feb 2004 22:17:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040223211718.GA7610@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040222232317.GA20083@mars.ravnborg.org> <20040223035321.9C52E2C069@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223035321.9C52E2C069@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:51:04PM +1100, Rusty Russell wrote:
> In message <20040222232317.GA20083@mars.ravnborg.org> you write:
> > The more correct approach is to list the .o files in the
> > .mod file. Then in sumversion find the corresponding .file.o.cmd, and parse
> > up the name of the corresponding source file (listed as the first filename
> > in the deps_ assignment, and pass this filename to grab_file.
> 
> OK, I've implemented that.  It doesn't complain about non-C files,
> although the parsing might be sub-optimal.
> 
> See get_source_name() for new code.  I also put the explicit depend on
> elfconfig.h in the Makefile.

Took a second look at it.
The reason why you parse the sourcefile, is to locate files included
from the local directory.
But this information is already available in the .module.o.cmd file,
so no reason to parse that information up from the .c file -
and eventually having troubles with .s files.

You can get rid of parse_cpp_line(), include_file(),
and some of the helpers when implementing this algorithm. So all
in all a good simplification.

Note also that in the original implementation you have missed
release_file() in a few places. But when you implement the above
you will hit them.

	Sam
