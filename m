Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbRAPMK3>; Tue, 16 Jan 2001 07:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbRAPMKT>; Tue, 16 Jan 2001 07:10:19 -0500
Received: from chiara.elte.hu ([157.181.150.200]:19217 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130916AbRAPMKM>;
	Tue, 16 Jan 2001 07:10:12 -0500
Date: Tue, 16 Jan 2001 13:09:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was:
 sendpath()]]
In-Reply-To: <Pine.LNX.4.30.0101161242180.529-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0101161307060.529-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Ingo Molnar wrote:

> 	struct lazy_filedesc {
> 		int fd;
> 		struct file *file;
> 	}

in fact "struct file" can (ab)used for this, no need for new structures or
new fields. Eg. file->f_flags contains the cached descriptor-information.
file->f_list is used for the current->lazy_files ringlist.

this way there is no additional allocation overhead in the worst-case.

(unless i'm missing something obvious.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
