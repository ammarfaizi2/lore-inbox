Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282298AbRKXAIR>; Fri, 23 Nov 2001 19:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282299AbRKXAIH>; Fri, 23 Nov 2001 19:08:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58629 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282298AbRKXAIC>; Fri, 23 Nov 2001 19:08:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moving ext3 journal file
Date: 23 Nov 2001 16:07:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tmocg$jfn$1@cesium.transmeta.com>
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo> <20011123155901.C1308@lynx.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011123155901.C1308@lynx.no>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> 
> Don't do that.  That is only good if the filesystem thinks that there
> is no journal, or it is using a hidden inode for the journal (i.e. if
> you run "tune2fs -l /dev/whatever" and it doesn't have "has_journal"
> listed in the filesystem features (this is what happened with 2.4.10).
> Otherwise, you will delete your real journal, tune2fs will complain,
> and then you will need to run e2fsck to clean up after yourself, before
> re-creating your journal again.
> 
> If you have a filesystem with a .journal file, and you want to "hide"
> it, just run e2fsck 1.25 while the filesystem is unmounted, and it
> will do it for you.  If you don't want to have a .journal in the first
> place, run tune2fs -j while the filesystem is unmounted.
> 

This is all fine and good except for the root partition (I'm pleased
to hear that e2fsck 1.25 will move the journal to the hidden inode for
non-root partitions.)  It would be nice if this was done automagically
by the mounting code instead of by fsck; that way migration would
truly be painless.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
