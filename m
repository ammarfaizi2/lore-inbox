Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266869AbRGKWxf>; Wed, 11 Jul 2001 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266871AbRGKWxZ>; Wed, 11 Jul 2001 18:53:25 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:5106 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S266869AbRGKWxQ>; Wed, 11 Jul 2001 18:53:16 -0400
Date: Wed, 11 Jul 2001 16:03:09 -0700 (PDT)
From: Lance Larsh <llarsh@oracle.com>
To: Brian Strand <bstrand@switchmanagement.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4C8263.6000407@switchmanagement.com>
Message-ID: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Brian Strand wrote:

> Our Oracle configuration is on reiserfs on lvm on Mylex.

I can pretty much tell you it's the reiser+lvm combination that is hurting
you here.  At the 2.5 kernel summit a few months back, I reported that
some of our servers experienced as much as 10-15x slowdown after we moved
to 2.4.  As it turned out, the problem was that the new servers (with
identical hardware to the old servers) were configured to use reiser+lvm,
whereas the older servers were using ext2 without lvm.  When we rebuilt
the new servers with ext2 alone, the problem disappeared.  (Note that we
also tried reiserfs without lvm, which was 5-6x slower than ext2 without
lvm.)

I ran lots of iozone tests which illustrated a huge difference in write
throughput between reiser and ext2.  Chris Mason sent me a patch which
improved the reiser case (removing an unnecessary commit), but it was
still noticeably slower than ext2.  Therefore I would recommend that
at this time reiser should not be used for Oracle database files.

Thanks,
Lance

