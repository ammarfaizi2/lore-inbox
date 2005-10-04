Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVJDUHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVJDUHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVJDUHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:07:51 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:11109 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964950AbVJDUHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=azRlM+GLzDAih8h2YHK23J6sCW0DF3A7teHyzQAC47pJSQYvfPOK3nyxuxYfPWCySWSfrMEUQpPJDZAOVr7GHDB+U93wyVL5fvc8sIuIcQkIq77KhPSyjRwpiRhn+AziOoSVL0akzK4+yG6u2Atc/w3Be7I4MtsUX7x0fume0WA=
Message-ID: <3e1162e60510041307q3fc900e7tdcf96eb268816eac@mail.gmail.com>
Date: Tue, 4 Oct 2005 13:07:48 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: /etc/mtab and per-process namespaces
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051004194301.GO7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
	 <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
	 <20051004194301.GO7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> > Hmm no responses on this thread a couple days now.  I guess:
> >
> > 1) No one cares about private namespaces or the fact that they make
> > /etc/mtab totally inconsistent.
> > 2) Private Namespaces aren't important to anyone and will never be
> > robust unless someone who cares, like me, takes it over somehow.
> > 3) Everyone is busy with their own shit and doesn't want to deal with
> > me or mine right now.
>
> 4) If you insist on having /etc/mtab the same file in all namespaces,
> you obviously will have its contents not matching at least some
> of them.  Either have it separate in each namespace where you want
> to see it, or simply use /proc/self/mounts instead.

Well I guess it's my fault to some extent with the subject line.  I
don't really care about /etc/mtab so much except that I'd like it to
be consistent if it is going to be there.  I'd rather it do one of two
things.  Show me my current process's namespace accurately or just the
stuff that's global to all namespaces.  Right now it's kind of in
between.

Also since when I type "mount" it just spits out what's in "mtab" it
seems like that should be made more accurate... not /proc/self/mounts.

(it looks like you can just edit the file and stick whatever you want
in there...  I just stuck the line:
 "blah blah blah"
in there and got:
"blah on blah type blah ()"
 from "mount" with no arguments)

>
> BTW, "private" is an odd term - they are all on the same footing; "system"
> one is just the namespace of init (and those of its descendents that share
> the namespace with it).  Nothing special about it...
>

It's actually a bit more like "protected" I suppose [in an OO
inheritance sense].  If I use clone with the right flags my new
process has a namespace that doesn't get reflected in the other
process's.  Sure I still inherit the parent's namespace, but I'm free
to bind to my hearts content in ways that other processes will not see
[unless they are children of the currently clone'd process].

Even in this "protected" namespace other processes can clearly see
what I'm doing via /etc/mtab.  It seems there will always be a way to
sniff out this information though since all the files of the form
/proc/<pid>/mounts are read accessible by everyone.

Dave
