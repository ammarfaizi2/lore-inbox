Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129961AbQK3W0a>; Thu, 30 Nov 2000 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQK3W0U>; Thu, 30 Nov 2000 17:26:20 -0500
Received: from 213-123-75-205.btconnect.com ([213.123.75.205]:8709 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129961AbQK3W0E>;
	Thu, 30 Nov 2000 17:26:04 -0500
Date: Thu, 30 Nov 2000 21:57:22 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Pavel Machek <pavel@suse.cz>
cc: Jan Rekorajski <baggins@sith.mimuw.edu.pl>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <20001130010057.B124@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0011302154500.1209-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Hardcoding things signifying special treatment of uid=0 is almost always a
> > > bad idea. If you _really_ think that superuser (whatever entity that might
> > > be) should be exempt from RLIMIT_NPROC and can prove that (SuSv2 seems to
> > > be silent so you may be right), then you should use capable() to do proper
> > > capability test and not that horrible explicit uid test as in your patch
> > > above.

I totally agree with you, Pavel. But while we are on this subject --
shouldn't the explicit check like this:

        /*
         * Use a reserved one if we're the superuser
         */
        if (files_stat.nr_free_files && !current->euid)
                goto used_one;
 
in fs/file_table.c:get_empty_filp() be switched to capabilities? I.e. is
the hardcoded euid=0 value intentional there or is it an omission?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
