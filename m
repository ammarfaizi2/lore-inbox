Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRKHQ3x>; Thu, 8 Nov 2001 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRKHQ3e>; Thu, 8 Nov 2001 11:29:34 -0500
Received: from moses.parsec.at ([212.236.50.196]:54541 "EHLO moses.parsec.at")
	by vger.kernel.org with ESMTP id <S275270AbRKHQ3T>;
	Thu, 8 Nov 2001 11:29:19 -0500
Date: Thu, 8 Nov 2001 17:29:05 +0100 (CET)
From: Andreas Gruenbacher <ag@bestbits.at>
To: Luka Renko <luka.renko@hermes.si>
cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@hermes.si
Subject: RE: [RFC][PATCH] extended attributes
In-Reply-To: <FED7EB450413D511ABC100B0D021173246D847@hal9000.hermes.si>
Message-ID: <Pine.LNX.4.21.0111081722240.4015-100000@moses.parsec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Luka Renko wrote:

> In http://acl.bestbits.at/man/extattr.5.html there is a statement:
> 
>    Device special files cannot be associated with extended user attributes 
> 
> What is the reason for this limitation? Why should there be a difference
> between regular files/directories and special files (device files)?

This limitation has been introduced since allowing extended user
attributes for special files leads to an awkward semantic mess: Extended
user attributes are in a sense treaded like file contents (concerning
permissions, for example). Now the "contents" of a special file are a
device, really. The device isn't even located on the filesystem the
special file is on. And the device doesn't have extended attributes.

It is possible to have devices on read-only file systems, which are
readable and writeable. It would not be possible to have extended
attributes in that case.

> I am also thinking in terms of HSM application (or DMAPI if you want). Where
> do you want HSM attributes to be placed? I thought it should be in trusted,
> because we might need access to them from user space. Other option is system
> (that would require accessing them from kernel code) or user (might be
> problematic, since regular user with write permission might remove them...

I am not sure about this. Just note that XFS and current ext2/ext3 don't
yet have the owner and trusted namespaces.

--Andreas.

