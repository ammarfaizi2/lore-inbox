Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVADBPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVADBPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVADBPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:15:14 -0500
Received: from dp.samba.org ([66.70.73.150]:30949 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261980AbVADBOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:14:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.60781.615644.171434@samba.org>
Date: Tue, 4 Jan 2005 12:12:13 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9EA09.8010302@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
	<41D9D65D.7050001@zytor.com>
	<16857.57572.25294.431752@samba.org>
	<41D9E23A.4010608@zytor.com>
	<16857.58819.311223.845400@samba.org>
	<41D9EA09.8010302@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The slightly stronger reason is basically the same reason why we don't 
 > stuff a bunch of things into a struct stat and call a single system call 
 > to change a bunch of attributes

yes, and if we want this to be a good API then we'd use something like
a bitmask to indicate what fields to update so we can update them in
groups in a raceless fashion, but that would require that the kernel
understand the internals of these structures. I didn't have that
luxury, so I grouped them in the way that best matched the common use
of the attributes.

 > you don't want to have to change them all every time, and by
 > putting them all in the same structure that's your only option,
 > since setxattr() doesn't allow you to mask and merge.

can you tell me who you imagining will be using these attributes apart
from Samba, Wine and backup/restore apps? 

 > 
 > Incidentally, the document you pointed me to wasn't clear on the 
 > endianness convention.

It's little-endian NDR. For a full description of NDR in all its gory
details see http://www.opengroup.org/onlinepubs/9629399/chap14.htm

NDR seems like overkill at first, until you start to look at security
descriptors. They are very complex beasts, and using IDL/NDR makes it
much easier (in fact, security descriptors need some minor
enhancements to NDR to encode them the same way windows does).

Cheers, Tridge
