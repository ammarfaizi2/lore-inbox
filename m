Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRBLI5n>; Mon, 12 Feb 2001 03:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129527AbRBLI5X>; Mon, 12 Feb 2001 03:57:23 -0500
Received: from mons.uio.no ([129.240.130.14]:21499 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129406AbRBLI5V>;
	Mon, 12 Feb 2001 03:57:21 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Olaf Hering <olh@suse.de>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 12 Feb 2001 09:57:01 +0100
In-Reply-To: "H. Peter Anvin"'s message of "Sun, 11 Feb 2001 12:31:38 -0800"
Message-ID: <shsbss8i8iq.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:

     > Olaf Hering wrote:
    >>
    >> Hi,
    >>
    >> there is a race in 2.4.1 and 2.4.2-pre3 in autofs/nfs.  When
    >> the cwd is on the nfs mounted server (== busy) and you try to
    >> reboot the shutdown hangs in "rcautofs stop". I can reproduce
    >> it everytime.
    >>

     > Sounds like an NFS bug in umount.

Or a dcache bug: the above points to a corruption of the mnt_count
which is supposed to be > 0 if the partition is in use. I'm seeing a
similar leak for ext2 partitions (not involving autofs or NFS).

Cheers,
   Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
