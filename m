Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTKKOiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTKKOiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:38:54 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:56216 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S263504AbTKKOiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:38:52 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Date: Tue, 11 Nov 2003 14:38:47 +0000
User-Agent: KMail/1.5.4
References: <fa.eto0cvm.1v20528@ifi.uio.no> <fa.onl48uv.1tmeb21@ifi.uio.no> <3FB0EEB5.5010804@myrealbox.com>
In-Reply-To: <3FB0EEB5.5010804@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111438.47868.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Nov 2003 2:14 pm, walt wrote:
> Sorry to be so dumb, but it seems to me that the two methods are exactly
> equivalent in every way:
>
> A test for file1 != file2 is exactly eqivalent to testing LOCK != NULL.
> It's a simple binary TRUE/FALSE test.
>
> What am I missing?  (BTW I'm not arguing against the two-file method.
> I just don't understand why it's different.)
>

So you check the lock, do rsync, and check the lock again. But the lock could 
have flipped several times during the rsync and you wouldn't know about it.

My preferred solution is a single sequence file as described by Adreas:

Assuming sequence starts at 0,

To modify the repository, +1 to sequence file contents, modify repo, +1 to 
sequence

To get a coherent copy,
do
	seq1 = read(sequence file)
	rsync repo
	seq2 = read(sequence file)
until seq1==seq2 and !(seq1&1)

