Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVAZXnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVAZXnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVAZXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:41:42 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:34827 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261667AbVAZSbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:31:21 -0500
Date: Wed, 26 Jan 2005 19:31:21 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-os <linux-os@analogic.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050126183121.GA93329@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-os <linux-os@analogic.com>, Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James Antill <james.antill@redhat.com>,
	Bryn Reeves <breeves@redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com> <20050126181006.GA80759@dspnet.fr.eu.org> <Pine.LNX.4.61.0501261315220.18301@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501261315220.18301@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:20:53PM -0500, linux-os wrote:
> On Wed, 26 Jan 2005, Olivier Galibert wrote:
> >Given that the man page itself says that unless you're using MAP_FIXED
> >start is only a hint and you should use 0 if you don't care things can
> >get real annoying real fast.  Imagine if you want to mmap a <4K file
> >and mmap then returns 0, i.e. NULL, as the mapping address as you
> >asked.  It's illegal from the point of view of susv3[1] and it's real
> >annoying in a C/C++ program.
> 
> mmap() can (will) return 0 if you use 0 as the hint and use MAP_FIXED
> at 0. That's the reason why one does NOT check for NULL with mmap() but
> for MAP_FAILED (which on this system is (void *)-1.

All the paragraph was under an obvious "when you do not use MAP_FIXED"
precondition.  The patch is not supposed to change anything to the
MAP_FIXED case.  Malloc does not use MAP_FIXED.  Usual file mmaping
as an alternative to read() does not use MAP_FIXED.

  OG.
