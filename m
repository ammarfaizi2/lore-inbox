Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUIHKB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUIHKB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUIHKB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:01:29 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:5843 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269083AbUIHKBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:01:25 -0400
From: Duncan Sands <baldrick@free.fr>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] netpoll endian fixes
Date: Wed, 8 Sep 2004 12:01:28 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200409080124.43530.baldrick@free.fr> <20040907235702.GC31237@waste.org>
In-Reply-To: <20040907235702.GC31237@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081201.28261.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like it ought to be 0x45 everywhere, meaning it's currently
> broken everywhere. But no one's complained. Unfortunately at the
> present moment I've got one machine short of a test rig unpacked, so
> I'm loathe to push another fix until I get some other test reports.

Hi Matt, I agree that it should be 0x45 everywhere.  After thinking a bit
I concluded that the

#if defined(__LITTLE_ENDIAN_BITFIELD)
        __u8    ihl:4,
                version:4;
#elif defined (__BIG_ENDIAN_BITFIELD)
        __u8    version:4,
                ihl:4;

in the definition of struct iphdr is to make sure that compiler uses the
first four bits of the byte to refer to version, rather than the last four;
and this only matters when you are accessing the nibbles via the ihl
or version structure fields.  Thus it makes sure that if you write 0x45
to the byte, then version will return 4 and ihl will return 5.  Presumably
the C standard specifies how bitfield expressions should be laid out
in the byte, and ihl:4, version:4; gives opposite results on little-endian
and big-endian machines...

Ciao,

Duncan.
