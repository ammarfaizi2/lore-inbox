Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSEUJEk>; Tue, 21 May 2002 05:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSEUJEj>; Tue, 21 May 2002 05:04:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57354 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S311749AbSEUJEj>; Tue, 21 May 2002 05:04:39 -0400
Message-ID: <3CEA0D65.DA25FB09@aitel.hist.no>
Date: Tue, 21 May 2002 11:03:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.12-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com> <20020517182942.GF627@matchmail.com> <20020517193410.W2693@redhat.com> <20020518013537.GH627@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
>
> Doesn't degraded mode imply that there are not any parity
> disk(raid4)/stripe(raid5) updates?
> 
Degraded mode means one of the (redundant) disks have
failed and isn't used.  In raid-4 that might be
the parity disk - and then you get the no parity
case.

But it might be a data disk that failed instead,
the missing data will be calculated from 
parity when needed, and of course parity is
modified upon write so information
can be stored even though some storage is missing.

Raid-5 spreads the parity over all the disks
for performance, so wether a missing disk
translates to a missing parity stripe or a missing
data stripe depends on the exact
block number.

Helge Hafting
