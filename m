Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934279AbWKTXGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934279AbWKTXGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934276AbWKTXGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:06:38 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:29895 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S934272AbWKTXGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:06:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Quadratic behavior of shrink_dcache_parent()
Date: Tue, 21 Nov 2006 00:03:12 +0100
User-Agent: KMail/1.9.1
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>
References: <E1Gm731-0003Br-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1Gm731-0003Br-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611210003.13417.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 November 2006 12:10, Miklos Szeredi wrote:
> The shrink_dcache_parent() can take a very long time for deep
> directory trees: minutes for depth of 100,000, probably hours for
> depth of 1,000,000.
> 
> The reason is that after dropping a leaf, it starts again from the
> root.

Oh, well.  So that's the reason why the shrinking of memory in swsusp can
take so much time.

> Filesystems affected include FUSE, NFS, CIFS.  Others I haven't
> checked.  NFS and to a lesser extent CIFS don't seem to efficiently
> handle lookups within such a deep hierarchy, so they're sort of
> immune.
> 
> But with FUSE it's pretty easy to DoS the system.
> 
> Limiting the depth to some sane value could work around this problem,
> but that would mean having to traverse subtrees in rename().
> 
> Any better ideas?

None, for now.  It looks like I need to learn that code ...

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
