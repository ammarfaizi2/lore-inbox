Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263448AbTC2SPf>; Sat, 29 Mar 2003 13:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263451AbTC2SPf>; Sat, 29 Mar 2003 13:15:35 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:18692 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263448AbTC2SPe>; Sat, 29 Mar 2003 13:15:34 -0500
From: john@grabjohn.com
Message-Id: <200303291829.h2TITPPi000418@81-2-122-30.bradfords.org.uk>
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
To: l.s.r@web.de (=?ISO-8859-1?Q?Ren=E9?= Scharfe)
Date: Sat, 29 Mar 2003 18:29:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20030329192616.72a397a4.l.s.r@web.de> from "=?ISO-8859-1?Q?Ren=E9?= Scharfe" at Mar 29, 2003 07:26:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch un-complicates a small piece of code of the dev/pts
> filesystem and decreases the size of the object code by 8 bytes
> for my build. Yay! :)

> -		err = PTR_ERR(devpts_mnt);
> -		if (!IS_ERR(devpts_mnt))
> -			err = 0;
> +		if (IS_ERR(devpts_mnt))
> +			err = PTR_ERR(devpts_mnt);

Why not use

err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));

?

John.
