Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVASLOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVASLOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVASLOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:14:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261686AbVASLOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:14:11 -0500
Date: Wed, 19 Jan 2005 11:14:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050119111405.GC12903@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>, karim@opersys.com,
	Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
	Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
	frankeh@watson.ibm.com
References: <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <16874.47855.427013.376104@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16874.47855.427013.376104@tut.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 01:05:19PM -0600, Tom Zanussi wrote:
> One of the things that uses these functions to read from a channel
> from within the kernel is the relayfs code that implements read(2), so
> taking them away means you wouldn't be able to use read() on a relayfs
> file.

Removing them from the public API is different from disallowing the
read operation.

> That wouldn't matter for ltt since it mmaps the file, but there
> are existing users of relayfs that do use relayfs this way.  In fact,
> most of the bug reports I've gotten are from people using it in this
> mode.  That doesn't mean though that it's necessarily the right thing
> for relayfs or these users to be doing if they have suitable
> alternatives for passing lower-volume messages in this way.  As others
> have mentioned, that seems to be the major question - should relayfs
> concentrate on being solely a high-speed data relay mechanism or
> should it try to be more, as it currently is implemented?

I'd say let it do one thing well, that is high-volume data transfer.

> If the
> former, then I wonder if you need a filesystem at all - all you have
> is a collection of mmappable buffers and the only thing the filesystem
> provides is the namespace.  Removing read()/write() and filesystem
> support would of course greatly simplify the code; I'd like to hear
> from any existing users though and see what they'd be missing.

What else would manage the namespace?

