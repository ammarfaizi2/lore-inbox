Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285179AbRLMUyY>; Thu, 13 Dec 2001 15:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285178AbRLMUyP>; Thu, 13 Dec 2001 15:54:15 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61839
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S285169AbRLMUyF>; Thu, 13 Dec 2001 15:54:05 -0500
Date: Thu, 13 Dec 2001 15:49:43 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: linux-kernel@vger.kernel.org, stewart@neuron.com,
        edward@thebsh.namesys.com
Subject: Re: passing params to boot readonly
Message-ID: <3420520000.1008276582@tiny>
In-Reply-To: <3372290000.1008274053@tiny>
In-Reply-To: <3C1841BB.8010003@neuron.com>
 <E16EPYW-0003nW-00@phalynx><3C1874D5.5050205@namesys.com>
 <E16EYh6-0004At-00@phalynx><3C18FB3D.7060206@namesys.com>
 <3372290000.1008274053@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========807285482=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========807285482==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Ok, the patch is attached, it was against 2.4.17-pre8 but should apply to
2.4.16 (let me know if you have problems).

To use, mount the FS with -o noreplay.  If there are transactions that need
to be replayed, it will force the FS readonly, otherwise, you get a normal rw
mount.  So, you might want to use -o ro,noreplay instead.

You'll need a boot disk with the patched 2.4.x kernel (it will be able to
read the 2.2.x reiserfs disk).

Now, with all of that said, I don't think this is the best way to poke around
on the degraded array (RAID5 with one disk dead?).  Grab the 3.x.0j version
of reiserfsprogs, and we can use debugreiserfs to get a look at what metadata
is still usable on the FS.

If the data is important, I'd strongly suggest finding a way to back it up (a
raw copy of the other two drives is better than nothing) before trying
anything fancy.  Even if this means a trip to the computer store and some
extra downtime.

-chris

--==========807285482==========
Content-Type: application/x-gunzip; name="noreplay-2.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="noreplay-2.diff.gz"; size=1855

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

--==========807285482==========--

