Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282312AbRKXA5o>; Fri, 23 Nov 2001 19:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282316AbRKXA50>; Fri, 23 Nov 2001 19:57:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282312AbRKXA5F>; Fri, 23 Nov 2001 19:57:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moving ext3 journal file
Date: 23 Nov 2001 16:56:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tmr83$jo2$1@cesium.transmeta.com>
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011123174120.Q1308@lynx.no>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> 
> Hmm, it could be added into the in-kernel ext3 journal recovery code, maybe,
> possibly, but it would be ugly I think.  I really don't see it as being a
> problem (other than a purely cosmetic one) to have a .journal file in your
> root fs.  I lived with these for a couple of years OK (even some of the
> early ext3 tools called them "journal.dat" (i.e. not a leading dot, ugh).
> 

It's either a cosmetic problem or a really problematic one, depending
on how closely controlled that particular part of the namespace is.
The .journal file could potentially try to be copied, backed up, you
name it.  Now, since this is now only an issue for the root partition,
this is much less of a problem (the risk for namespace problems in /
are much less.)

> In 2.5 it would be easy (and preferrable for other reasons) to have e2fsck
> run from the initramfs on the root fs before it is mounted.  That solves
> the problem nicely without adding bloat into the kernel.  We could even
> remove the in-kernel journal recovery at that point if we thought that the
> initramfs was a reliable environment to host _critical_ boot tools. 

You can do that now via initrd as well.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
