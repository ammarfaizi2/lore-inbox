Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbULJQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbULJQfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULJQfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:35:52 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:17687 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261752AbULJQfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:35:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kIkmnV2lox75ftbmJkQdUv9qDH1NNA9pyOSyMHcD9fUfrb7xVwbSpmwd/zEOproLJ9Xk2u/92/MbOo3JrB41LzM6yr8offk3YHggWhNBoi4+LAjtEOzIEU0+efcCgtITVEO1Vrbatktr3URMSgmhFT7I8KbY1l3wjYzX3b/vhj0=
Message-ID: <f2833c760412100835281c3ef9@mail.gmail.com>
Date: Fri, 10 Dec 2004 16:35:10 +0000
From: Timothy Chavez <chavezt@gmail.com>
Reply-To: Timothy Chavez <chavezt@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: [audit] Upstream solution for auditing file system objects
Cc: linux-kernel@vger.kernel.org, serue@us.ltcfwd.linux.ibm.com,
       sds@epoch.ncsc.mil, rml@novell.com, ttb@tentacle.dhs.org
In-Reply-To: <200412101429.iBAETIs9029152@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f2833c760412091602354b4c95@mail.gmail.com>
	 <200412101429.iBAETIs9029152@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004 09:29:18 -0500, Valdis.Kletnieks@vt.edu
<Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 10 Dec 2004 00:02:31 GMT, Timothy Chavez said:
> 
> > Over the last two months, I've been given the daunting task of
> > implementing a feature by which an administrator can specify from user
> > space, a list of file system objects (namely regular files and
> > directories) that he/she wishes to audit.
> 
> One *big* question that you don't address at all in your mail:
> 
> Do you need *real time* tracking of changes/etc, in which case inotify or
> something based on it are probably an approach to follow (note that I don't
> think inotify currently deals with read-only access to a file).
> 
> Or do you not care about real-time tracking, but have a requirement to be
> able to go back and say "Oh, at 9:03:38.99342 last Tuesday, user XYZ
> tried to open this file" - if that's what you want, you probably want to
> look at the audit subsystem and its support for syscall auditing.
> 
Valdis,

Thank you for the reply.  There is no need for real-time tracking to
meet this requirement.  You have the right idea with the timestamped
message.

And yes, the audit subsystem that's in existence now is something we
want to work with and improve.  Like I had mentioned earlier, it could
just be a matter of logging the VFS relevant portion ("this
<file/directory> was accessed / altered by") with the same serial
number as the syscall ("open() called under these <conditions>") and
then piecing the entire audit record together in userspace and filter
it accordingly.

The main goal here is to not be redundant and make use of our
resources.  I personally like Robert's idea with the general hooking
framework.  Making the audit subsystem, itself, modular also sounds
like a pretty good idea.

Thanks again!

-- 
- Timothy R. Chavez
