Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTDHWMr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbTDHWMr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:12:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60805 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261928AbTDHWMp (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:12:45 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 9 Apr 2003 00:24:22 +0200 (MEST)
Message-Id: <UTC200304082224.h38MOMw14495.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: ioctls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This night I did some ioctl work, and the longer
one looks at this stuff, the messier it turns out to be.

(i)
First one has the definitions:

#define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),sizeof(size))
#define _IOW(type,nr,size)      _IOC(_IOC_WRITE,(type),(nr),sizeof(size))

These are really unfortunate. I suppose I'll submit a patch
to change the definition into

#define _IOR(group,nr,argtype)  _IOC(_IOC_READ,(group),(nr),sizeof(argtype))

Really a lot of people have been fooled into believing that
the parameter "size" is a size.  But it is a data type.


(ii)
In all cases where the size is wrong (a largish number of cases),
do we want to define the "correct" ioctls, and leave the old
ones with _OLD suffix as deprecated?


(iii)
For userspace it is difficult to get ioctl definitions.
All the obscure ioctls live in <linux/foo.h> and including
lots of such headers is a sure way to get a source that
doesnt compile. Typedef clashes, things outside #ifdef __KERNEL__
that use things inside, etc etc.
Would anyone object against creating a directory with a
name like kernelapi and slowly moving manifest constants,
ioctl definitions, and definitions of the argument structs
to files there?
This is easy since there is no flag day. File by file things
can be moved, leaving a #include in <linux/foo.h>.
An attempt can be made to keep the namespace under kernelapi clean.
Now userspace can include <kernelapi/foo.h> and __KERNEL__ can disappear.

Andries
