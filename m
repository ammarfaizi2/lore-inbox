Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSEUEQS>; Tue, 21 May 2002 00:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316504AbSEUEQR>; Tue, 21 May 2002 00:16:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27077 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316503AbSEUEQQ>;
	Tue, 21 May 2002 00:16:16 -0400
Date: Mon, 20 May 2002 21:02:20 -0700 (PDT)
Message-Id: <20020520.210220.99529819.davem@redhat.com>
To: adilger@clusterfs.com
Cc: quintela@mandrakesoft.com, fmfkrauss@mindspring.com,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020521035702.GA9901@turbolinux.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Dilger <adilger@clusterfs.com>
   Date: Mon, 20 May 2002 21:57:02 -0600

   It is likely that block is being set as -EPERM or something like that,
   but I'm not sure.

Interesting analysis.

However, I walked over this code a few times and I cannot
find a way that -EPERM can land there.

What might be happening, instead, is that due to some bug
in ext2_alloc_block we end up with -1 as the answer.  It
would be useful to add some debugging there to see if the
return value 'j' is ever -1 when we set *err to '0'.
