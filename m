Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTH2IRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTH2IRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:17:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264429AbTH2IRw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:17:52 -0400
Date: Fri, 29 Aug 2003 09:17:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ->pid in filesystem code
Message-ID: <20030829081750.GY454@parcelfarce.linux.theplanet.co.uk>
References: <3F4E5426.6050401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4E5426.6050401@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 12:12:38PM -0700, Ulrich Drepper wrote:
> cifs:
> 
>   apparently uses current->pid to keep track of locking.  This might
>   mean that the current implementation is actually getting things very
>   wrong, at least from the Unix semantics.  Locking happens on process
>   basis.  I count 11 uses of ->pid, all suspicious.  Using this
>   filesystem with NPTL seems to be risky in the moment.

s/with NPTL//.  I'm fairly certain that fs/cifs went into the tree without
a review and what's more, in this case I have very strong suspicion that
it might have been deliberately obfuscated to scare potential reviewers off.
Whatever the cause might be, the code *is* obfuscated enough to make it very
hard to review and it certainly contains a lot of dubious stuff.

 
> intermezzo:
> 
>   Wow, don't know where to start.  A gazillion uses of ->pid.  Some are
>   print statements but there are others where the value is assigned to
>   elements of some internal data structures.  I think I would strongly
>   suggest to avoid this filesystem when using NPTL until it is clear
>   that there are no issues.

intermezzo needs a serious rewrite before it will be usable in 2.6.  Authors
had promised to do something about it, but so far it hadn't reached the Linus'
tree.
 
> umsdos:
> 
>   The pid seems to be used for some kind of locking.  Might be that
>   using ->pid is correct here.  In that case it needs comments.

Doesn't even build.  Will need a rewrite or removal - it had been rotting
for a *long* time.
