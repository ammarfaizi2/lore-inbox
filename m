Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbRL0Nhm>; Thu, 27 Dec 2001 08:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286268AbRL0Nhd>; Thu, 27 Dec 2001 08:37:33 -0500
Received: from fungus.teststation.com ([212.32.186.211]:41221 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S285118AbRL0NhW>; Thu, 27 Dec 2001 08:37:22 -0500
Date: Thu, 27 Dec 2001 14:37:16 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SMBFS reading & Time sync problem
In-Reply-To: <EF836A380096D511AD9000B0D021B52746370A@narmada.ctd.hcltech.com>
Message-ID: <Pine.LNX.4.33.0112271359390.25461-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Eshwar D - CTD, Chennai. wrote:

> Hai,
> 	I am using kernel version 2.4.2. and samba version is 2.2.0. and

2.4.3 may have a fix for this if the size of the file changes. Upgrade to
a newer kernel and see if this doesn't work better there.

smbfs does not really support this kind of sharing anyway. It caches
things without having an "oplock" on the server. Without an oplock it
should always re-read everything (hard to do for mmap'ed files).

There is also an assumption in a lot of the code that the file does not
change on the server.


>  To avoid this problem my suggestion is
> 
> 	1. While every write the modified time to be notified to sever by
> sending SMBsetattr.

That will cut the transfer rate in half (roughly) and there is no
guarantee that it will work as some servers do not seem to respond with
the recently written attributes.

I don't think that is the best way to do this. oplocks + proper
invalidation should be a lot safer. Setting attributes depends on the
clocks of the machines being somewhat in sync.


Please test 2.4.17 (or a more recent kernel from your vendor). If that
doesn't work could you then send me a testprogram/script that triggers
this. Thanks.

/Urban

