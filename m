Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUHEPKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUHEPKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHEPKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:10:38 -0400
Received: from [193.112.238.6] ([193.112.238.6]:39135 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S267749AbUHEPKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:10:35 -0400
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Program-invoking Symbolic Links?
Date: Thu, 5 Aug 2004 16:08:39 +0100
User-Agent: KMail/1.6.1
Cc: William Stearns <wstearns@pobox.com>
References: <200408051504.26203.jmc@xisl.com> <Pine.LNX.4.58.0408051027090.3293@sparrow>
In-Reply-To: <Pine.LNX.4.58.0408051027090.3293@sparrow>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051608.39183.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC to jmc @ xisl.com

On Thursday 05 Aug 2004 15:34, William Stearns wrote:
> Good morning, John,
> 	(My apologies for floating offtopic for kernel programming.  I
> wanted to provide a quick example for John and others interested in doing
> this so they could see this can be done outside of the kernel.)
>
> On Thu, 5 Aug 2004, John M Collins wrote:
> > (Please CC any reply to jmc AT xisl.com as I'm not subbed - thanks).
> >
> > I wondered if anyone had ever thought of implementing an alternative form
> > of symbolic link which was in fact an invocation of a program?
> >
> > Such a symbolic link would "do all the necessary" to fork off a new
> > process running the specified program with input or output from or to a
> > pipe depending on whether the link was opened for writing or reading
> > respectively. RW access would probably have to be banned and the link
> > would usually be read-only or write-only.
> >
> > What I originally wanted was symbolic links (with "=>" as a possible
> > notation).
> >
> > latest_version.tar => "tar cf - /latest/and/greatest"
> > latest_version.tgz => "gzip -c latest_version"
> >
> > and the like, which I could link on a website so I didn't have to run
> > around updating tar files/zip files/gzipped tar files etc each time I fix
> > a bug in some package.
>
> 	Is there any reason this couldn't be done in userspace by using
> named pipes instead of a new form of symlink?
>
> #!/bin/bash
>
> if [ ! -e livepipe ]; then
> 	echo Making livepipe >&2
> 	mkfifo livepipe
> fi
>
> while : ; do
> 	echo -n . >&2
> 	( date ) >livepipe
> 	sleep 1
> done

That wouldn't do what I want. Besides which, I've tried it on Apache and it 
doesn't work. Apache isn't fooled by fifos called something.html Nor are most 
browsers either.

1. The "other end" of the named pipe would be run under the identity of 
whoever kicked off that daemon process not the user who wanted to access it.

2. The environment etc would be that which the "other end" was kicked off 
with, not what you might want it to be when the thing is accessed. In your 
example the stuff up to the "(date) >livepipe" will all get run, and then 
things will get suspended until there is a reader for "livepipe" by which 
time all the work you've done up to that point might be invalidated.

3. There would be no way of getting at the invoking environment, supposing for 
example you wanted to give a different response to different users?

4. In the example I quoted where you want to have a "give me a tarball of the 
latest version of package X" link you'd have to have one continually-running 
process to serve package X, one for package Y, one for package Z and so 
forth.

-- 
John Collins Xi Software Ltd www.xisl.com
