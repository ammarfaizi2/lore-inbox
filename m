Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGCDCy>; Tue, 2 Jul 2002 23:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGCDCx>; Tue, 2 Jul 2002 23:02:53 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:25865 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S314451AbSGCDCw>; Tue, 2 Jul 2002 23:02:52 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Matthew Wilcox <willy@debian.org>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs() 
cc: pmenage@ensim.com
In-reply-to: Your message of "Wed, 03 Jul 2002 03:57:44 BST."
             <20020703035744.K27706@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jul 2002 20:04:54 -0700
Message-Id: <E17PaRq-0004N1-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jul 02, 2002 at 06:25:47PM -0700, Paul Menage wrote:
>> This patch removes BKL protection from the invocation of the
>> super_operations ->statfs() method, and shifts it into the filesystems
>> where necessary. Any out-of-tree filesystems may need to take the BKL in
>> their statfs() methods if they were relying on it for synchronisation.
>
>Sure, makes sense to do.  For real credit though, let's see how much we
>need the BKL.  In ext2's statfs, we reference:
>

I'm sure the BKL can be ripped out further, but I preferred not to risk
breakage in this patch due to unfamiliarity with the locking rules for
particular filesystems - I just left the BKL out of those that were 
clearly not touching mutable data. Patches that shrink the BKL usage for 
individual filesystems can be sent (hopefully with copious 
justifications) once this or something like it is applied.

Paul

