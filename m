Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268559AbTGIV3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 17:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbTGIV3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 17:29:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268559AbTGIV3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 17:29:17 -0400
Message-ID: <3F0C8C85.6090604@pobox.com>
Date: Wed, 09 Jul 2003 17:43:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
References: <20030709133109.A23587@infradead.org>	<Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>	<16140.24595.438954.609504@charged.uio.no>	<200307092041.42608.m.c.p@wolk-project.de>	<16140.25619.963866.474510@charged.uio.no>	<20030709190531.GF15293@gtf.org>	<16140.26693.72927.451259@charged.uio.no>	<20030709191739.GH15293@gtf.org> <16140.29271.365874.304823@charged.uio.no>
In-Reply-To: <16140.29271.365874.304823@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>>>>>" " == Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>      > Having the stable API change, conditional on a define, is
>      > really nasty and IMO will create maintenance and support
>      > headaches down the line.  I do not recall Linux VFS _ever_
>      > having a hook's definition conditional.  We should not start
>      > now...
> 
> direct_IO() was precisely such a conditional hook definition. It
> appeared in 2.4.15, and anybody who does not check for
> KERNEL_HAS_O_DIRECT is not backward compatible.

You misunderstand.  The 2.4.15 direct_IO hook was _not_ conditionally 
defined.  It appeared in the middle of a stable series, yes.  It has a 
feature macro, yes.  But the definition of the hook in 
include/linux/fs.h does not _change_ based on a define.  That is what I 
mean by a conditional hook definition.

It is far less trouble for everyone to add a new hook, instead of 
changing an existing hook, in the middle of a stable series.


> To comment further: There is at least one example I can think of which
> was exactly equivalent to the proposed change, namely the redefinition
> of the filldir_t type in 2.4.9. It was admittedly not documented using
> a define...

No doubt you can find more :)  That doesn't make the right thing to do, 
though :)


> Note: We could at the same time replace the name direct_IO() with
> direct_IO2() (that has several precedents).  There are currently only
> a small number of filesystems that provide O_DIRECT, and converting
> them all is (as has been pointed out before) trivial...

We cannot just-fix-up filesystems which are not in-tree, which is what 
the KERNEL_HAS_O_DIRECT2 define would be mainly used for.  In-tree 
filesystems would just unconditionally use the new, or old, interface as 
they chose.


> The problem with read_inode2() was rather that it overloaded the the
> existing iget4() interface...

The higher-level problem was that we didn't want to change the VFS 
API...  otherwise we could have simply used the new interface, and 
converted all in-tree filesystems.

	Jeff



