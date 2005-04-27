Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVD0POZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVD0POZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVD0POZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:14:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:46493 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261711AbVD0POR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:14:17 -0400
Date: Wed, 27 Apr 2005 17:13:57 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Florian Weimer <fw@DENEB.ENYO.DE>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
       mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-ID: <20050427151357.GH1087@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Florian Weimer <fw@DENEB.ENYO.DE>,
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871x8wb6w4.fsf@deneb.enyo.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Directory hashing has a negative impact on some applications (notably
> tar and unpatched mutt on large Maildir folders).  For git, it's a win
> because hashing destroys locality anyway.

this is inaccurate. Actually turning on directory hashing speeds-up big
maildirs a lot (tested with mutt-1.5.4 and higher with a maildir
containing 30thousand messages). But in the mutt case you also have the
header cache[1] which speeds up a lot - with or without hashed
directories. See also MEs comment[2] on this.

For tar I have no idea why it should slow down the operation, but maybe
you can enlighten us.

	Thomas

[1] http://wwwcip.informatik.uni-erlangen.de/~sithglan/mutt/
	- wait till TLR has released mutt-1.5.10
	- use mutt CVS HEAD
	- use mutt-1.5.9 + http://wwwcip.informatik.uni-erlangen.de/~sithglan/mutt/mutt-cvs-header-cache.29
	- and put the following in your .muttrc:
	set header_cache=/tmp/login-hcache
	set maildir_header_cache_verify=no

[2] http://www.advogato.org/person/scandal/
