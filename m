Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUA1Nub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUA1Nub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:50:31 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:12767 "EHLO
	albatross-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id S265982AbUA1Nu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:50:29 -0500
X-Sybari-Trust: f0329ee5 6b512624 6fee668e 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Wed, 28 Jan 2004 14:50:02 +0100 (MET)
Message-Id: <200401281350.i0SDo2I03247@duna48.eth.ericsson.se>
To: azz@us-lot.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net> (message from Adam
	Sampson on Tue, 27 Jan 2004 00:43:21 +0000)
Subject: Userspace filesystems (WAS: Encrypted Filesystem)
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adam Sampson <azz@us-lot.org> wrote:

> Is there a technical reason that none of the userspace filesystem
> layers have been included in the stock kernel, or is it just that
> nobody's submitted any of them for inclusion yet?

I'm planning on submitting FUSE for inclusion into 2.7 (and maybe 2.6
if that is acceptable).  I feel that FUSE has been maturing lately
with some very interesting applications [1].

Here are the reasons for _not_ including it:

 1) There are already two filesystems in kernel that are perfectly
    usable for this purpose: NFS and CODA

 2) There are currently two competing userspace filesystem layers that
    have about the same "market share": LUFS and FUSE.  Why should we
    prefer one over the other

I'll try to refute myself on these points:

 1) Both NFS and CODA were designed for something different.  IOW they
    are not optimized for the purpose of supporting userspace
    filesystems.  NFS is slow and there are problems with coherency of
    the underlying and the mounted filesystem.  CODA does not support
    random file access (or even streaming), only reading whole files.
    It also has a miriad of small problems when used for exporting a
    userspace fs (I've been personally burned many times while doing
    AVFS over CODA).

 2) This one is harder to get rid of, especially because I don't want
    to delve into the technical merits of one or the other (I'd be a
    bit biased).  But I have compared both the kernel interface and
    the library API of LUFS and FUSE and they are very similar.  And
    that is a good thing, because it makes possible to support LUFS
    filesystems with the FUSE kernel module and vica versa.


Miklos

[1] For a list of applications using FUSE see:

   <http://www.inf.bme.hu/~mszeredi/fuse/Filesystems>
