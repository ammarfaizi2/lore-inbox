Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSH0RWZ>; Tue, 27 Aug 2002 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSH0RWZ>; Tue, 27 Aug 2002 13:22:25 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:39580 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316610AbSH0RWY>; Tue, 27 Aug 2002 13:22:24 -0400
Date: Tue, 27 Aug 2002 13:26:44 -0400
To: linux-kernel@vger.kernel.org
Cc: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Loop devices under NTFS
Message-ID: <20020827172643.GE11780@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Adam J. Richter" <adam@yggdrasil.com>
References: <200208271353.GAA04875@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208271353.GAA04875@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
> >Depending on the filesystem implementation _anything_ may happen.
> >With current intree filesystems the only real life problem is that
> >it doesn't work on certain filesystems.
> 
> 	Sorry for repeating myself here: If you're referring to the
> stock loop.c not working with tmpfs because tmpfs lacks
> {prepare,commit}_write which my patch works around (based on Jari's
> patch before mine, and a patch by Andrew Morton as well).  I have yet
> to hear a clear reason why any writable plain file on any given file
> system could not have {prepare,commit}_write operations available.
...
> 	Please come up with a clear example.  I'm not asking you for a
> test case that can produce it, just some narrative of the problem
> occurring.

Not all filesystems use generic_read/generic_write. If they did we
wouldn't need those calls in the fops structure.

Ofcourse the prepar_write/commit_write were introduced later on and
perhaps it is possible to modify all filesystems to put all their
custom functionality in these functions. Then we can simply remove the
read and write (and mmap?) fops, i.e. force everyone to use the provided
generic read/write functions.

But as long as a filesystem is allowed to provide it's own functions,
any wrapper should never assume that generic operations will work.

The clear example you are looking for is probably Coda, most others
filesystems simply wrap the generic_ function plus some minor
functionality (like setting the ctime).

Jan

