Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSBDSuU>; Mon, 4 Feb 2002 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286871AbSBDSuK>; Mon, 4 Feb 2002 13:50:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36625 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285073AbSBDStO>;
	Mon, 4 Feb 2002 13:49:14 -0500
Message-ID: <3C5ED7A6.C28407BA@mandrakesoft.com>
Date: Mon, 04 Feb 2002 13:49:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <1012835730.26397.519.camel@jen.americas.sgi.com> <E16XlK0-0007Wu-00@the-village.bc.nu> <20020204182942.C2092@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> should know the caches might be inconsistent.  Large O_DIRECT users,
> such as databases, already know this.  They are happily ignorant of
> cache inconsistencies.  All they care about is hardsectsize O_DIRECT
> operations.

I have similar inclination, that is inspired from the implementation of
"NTFS TNG": hard sector size should always equal sb->blocksize.  This
allows for fine-grained operations at the O_DIRECT level, logical block
sizes > PAGE_CACHE_SIZE, easy implementation of fragments (>= hard sect
size), O_DIRECT for fragments, and other stuff.

This works right now in 2.4 and 2.5 with no modification to the VFS
core.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
