Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbTGJHiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbTGJHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:38:53 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:23309 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269010AbTGJHiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:38:51 -0400
Date: Thu, 10 Jul 2003 08:53:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710085325.A28672@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	torvalds@osdl.org
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva> <20030709211645.40353fc2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030709211645.40353fc2.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 09, 2003 at 09:16:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 09:16:45PM -0700, Andrew Morton wrote:
> >  I reverted the direct IO patches because hch complained on me that they
> >  change the direct IO API, and we really dont want that kind of
> >  change, IMHO.
> 
> OK, we're on to a specific case.  Albeit a very small one.
> 
> I think Trond's direct IO change was right.  The impact on out-of-tree code
> is infinitesimal.  Stick a #define O_DIRECT_NEEDS_A_FILP in the header and
> let the XFS guys write a four-line patch.

Oh, we have that patch even without the feature define in say -ac and -aa
but it's just horrible to have APIs silently change behind you.  Especially
when just changing a function arg where you only get one more warning in
the forrest of warnings produced by gcc 3.3 on a 2.4 tree..

> Or merge XFS.

That's of course a good idea [1] but doesn't really help in this discussion.
There's other filesystems like ocfs or opengfs that have the same kind
of problems.

[1] and with the new quota code and vmap() we're almost there..

