Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269149AbUJESRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269149AbUJESRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJESRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:17:52 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:34123 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269152AbUJESR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:17:27 -0400
Message-ID: <4162E61F.5000103@novell.com>
Date: Tue, 05 Oct 2004 14:21:19 -0400
From: Jeff Mahoney <jeffm@novell.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Alex Zarochentsev <zam@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] I/O Error Handling for ReiserFS v3
References: <20041005150819.GA30046@locomotive.unixthugs.org> <4162C156.3030108@namesys.com> <20041005172233.GE28617@backtop.namesys.com> <4162DCAA.50902@namesys.com>
In-Reply-To: <4162DCAA.50902@namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
| Alex Zarochentsev wrote:
|
|> On Tue, Oct 05, 2004 at 08:44:22AM -0700, Hans Reiser wrote:
|>
|>
|>> These have received design approval from zam (and thus me), but zam,
|>> did they receive stress testing by Elena under your guidance?
|>>
|>
|>
|> No. We have a long queue of test tasks.  There are fsck.reiser4 testing,
|> reiser4/dmapper crashes and the benchmarks in the queue.
|>
| Well, we cannot let our process be a barrier to good patches getting in,
| so let me ask, Jeff, did you test each of these conditions you
| improved?  How?  Did anyone else test them?

The "testing" version of the code had a another conditional added to
each of the !buffer_update tests that allowed me to trigger an I/O error
handling at each error point. The I/O error path is obviously more
difficult to test in real-world conditions as I/O errors could be caused
by any number of failures.

The testing was done using fsx-linux, the LTP fsstress program, and
stress.sh, sometimes all at once.

This code has also been active in the SUSE Linux Enterprise Server 9
kernel for some time and has seen real-world testing to show that the
normal path is still working as expected.

The end result for the i/o error path is that the write operations still
happen, but the commit block is never written. This means that the end
result is essentially the same as a power outage at the point of
failure. The filesystem is then read-only until the user decides to
umount and correct the problem that caused the I/O error in the first place.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBYuYfLPWxlyuTD7IRAt1OAJ9RgkYWrCKikftGephpWWGlS+acSQCgjDwm
cxcXvSVyldRsJZdagvatw0Y=
=DuY9
-----END PGP SIGNATURE-----
