Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284745AbRLLArJ>; Tue, 11 Dec 2001 19:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284768AbRLLAq6>; Tue, 11 Dec 2001 19:46:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284745AbRLLAqp>; Tue, 11 Dec 2001 19:46:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: knfsd and FS_REQUIRES_DEV
Date: Wed, 12 Dec 2001 00:46:10 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9v69ci$5e1$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112111810160.541-100000@devserv.devel.redhat.com> <20011211.162011.21927662.davem@redhat.com>
X-Trace: palladium.transmeta.com 1008117979 10260 127.0.0.1 (12 Dec 2001 00:46:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Dec 2001 00:46:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011211.162011.21927662.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>   From: Elliot Lee <sopwith@redhat.com>
>   Date: Tue, 11 Dec 2001 19:13:48 -0500 (EST)
>
>   I'm looking for information on knfsd's requirement that a filesystem be
>   FS_REQUIRES_DEV in order to export it. Would someone point me in the right
>   direction?
>   
>   Needing to implement some not-quite-kosher exports,
>
>NFSD puts dev/ino into the filehandles it gives to the
>client, it uses this to lookup the inode in question.

Well, that actually could work with things like /proc, which actually
has meaningful inode numbers. They may not be stable across reboots, of
course, nor even really stable in general, but in _theory_ there's
nothing to keep us from exporting /proc files and potentially other
virtual filesystems.

In practice I suspect there are tons of other problems, not the least of
which is that /proc doesn't give a proper filesize. 

Other not-so-kosher filesystems (ie tmpfs) might be easier than /proc in
those respects. 

		Linus
