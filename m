Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbREFKRZ>; Sun, 6 May 2001 06:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135345AbREFKRQ>; Sun, 6 May 2001 06:17:16 -0400
Received: from fungus.teststation.com ([212.32.186.211]:2969 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S135323AbREFKRC>; Sun, 6 May 2001 06:17:02 -0400
Date: Sun, 6 May 2001 12:16:58 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <3AF4974C.D5D85498@baldauf.org>
Message-ID: <Pine.LNX.4.30.0105061202340.20337-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Xuan Baldauf wrote:

> it does not fix|work around the bug completely:
> 
> 1. windows: Create a file, e.g. with 741 bytes.
> 2. linux: "ls -la" will show you the file with the correct size (741)
> 3. linux: read the file into your smbfs cache (e.g. "less file")
> 4. windows: add some contents to the file, e.g. so that it is now 896 bytes
> long
> 5. linux: "ls -la" will show you the file with the correct size (896)
> 6. linux: read the file (e.g. "less file")

Ah, but now you are talking about a different bug.

Your original testcase only contained changes from the smbfs client (the
abc/xyz test). For me that is solved by this patch and I wanted you to
check if it did in your environment as well.

I have one other report of something being broken with changes made on the
server side only.

There is also yet another problem if you change a file from smbfs and from
the server. The smbfs side will remember the wrong filesize. This may be a
fix for that:
http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.4-truncate+retry-3.patch
								(-3, not -2)

/Urban

