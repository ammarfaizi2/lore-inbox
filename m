Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTDIEy3 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTDIEy3 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:54:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5536 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262754AbTDIEy2 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:54:28 -0400
Date: Wed, 9 Apr 2003 01:06:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200304090506.h39564208670@devserv.devel.redhat.com>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, arjanv@redhat.com
Subject: Re: ioctls
In-Reply-To: <mailman.1049841061.29063.linux-kernel2news@redhat.com>
References: <mailman.1049841061.29063.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (i)
> First one has the definitions:
> 
> #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),sizeof(size))
> #define _IOW(type,nr,size)      _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
> 
> These are really unfortunate. I suppose I'll submit a patch
> to change the definition into
> 
> #define _IOR(group,nr,argtype)  _IOC(_IOC_READ,(group),(nr),sizeof(argtype))
> 
> Really a lot of people have been fooled into believing that
> the parameter "size" is a size.  But it is a data type.

Great idea! I actualy wanted it changed too, but could not find
two suitable English words. Perhaps that's why Linus blew it.
Wait... you aren't a native speaker either? :-)  Anyway, I like it.
Just about anything is better than what we have now.

> (ii)
> In all cases where the size is wrong (a largish number of cases),
> do we want to define the "correct" ioctls, and leave the old
> ones with _OLD suffix as deprecated?

I would not touch anything, but add a comment near every
instance (/* THIS IS BROKEN DOUBLE sizeof, DO NOT COPY */).

> (iii)
> For userspace it is difficult to get ioctl definitions.
> All the obscure ioctls live in <linux/foo.h> and including
> lots of such headers is a sure way to get a source that
> doesnt compile. Typedef clashes, things outside #ifdef __KERNEL__
> that use things inside, etc etc.
> Would anyone object against creating a directory with a
> name like kernelapi and slowly moving manifest constants,
> ioctl definitions, and definitions of the argument structs
> to files there?

There was a more comprehensive idea floated by Chrishtoff
Hellwig last week. We ought to ask Arjan (or find someone
else) to maintain glibc-kernelheaders as a community tarball
at kernel.org somewhere. Please, don't look at me. OK, only
if Arjan _REALLY_ refuses... Or perhaps you want to take
it yourself? This is basically your idea, only halfway
done: everything is copied already. Also, we do not need
a buy-in from Linus (though I suspect he'd support it).

-- Pete
