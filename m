Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUBXB00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbUBXBQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:16:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:8074 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262166AbUBXBNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:13:53 -0500
X-Authenticated: #20799612
Date: Tue, 24 Feb 2004 01:13:13 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040224001313.GA6426@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223202524.GC13914@hobbes> <20040223140027.5c035157.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223140027.5c035157.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:00:27PM -0800, Paul Jackson wrote:
> Hansjoerg wrote:
> > I still don't understand your argument... If there is a shell having
> > those problems, nobody would use something like
> 
> I will acknowledge that while one _could_ code a shell so that your
> proposed change would break it, it would be a stupid, silly and ugly
> way to code a shell.
> 
> That is, one _could_ code a shell to say:
> 
>  1) If argv[1] starts with a '-', consume and handle as an option
>     (or possibly as a space separated list of options).
>  2) Presume the next argument, if any, is a shell script file.

There is no problem with such a shell if you use scripts beginning with

#!/some/shell

or

#!/some/shell -some_arg

if some_arg does not contain whitespace characters. In both cases,
argv will be the same as it is with the current code.

/some/script param1 param2

will become

/some/shell /some/script param1 param2

or

/some/shell -some_arg /some/script param1 param2

as it has been before.

There is a problem with a shebang line like

#!/some/shell -x -y

_but_ this was most probably an error, before. (Unless this shell
accepts _one_ parameter "-x -y" containing a space.)

So, I really can't see any problem with such a shell...

Regards,

	Hansjoerg Lipp
