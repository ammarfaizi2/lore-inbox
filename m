Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVKIOdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVKIOdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVKIOdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:33:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43184 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750962AbVKIOdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:33:16 -0500
Date: Wed, 9 Nov 2005 14:33:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
Subject: Re: [PATCH 13/18] shared mounts handling: move
Message-ID: <20051109143315.GW7992@ftp.linux.org.uk>
References: <E1EZInj-0001F1-Aj@ZenIV.linux.org.uk> <E1EZnuQ-0001Bg-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EZnuQ-0001Bg-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 12:14:30PM +0100, Miklos Szeredi wrote:
> > From: Ram Pai <linuxram@us.ibm.com>
> > Date: 1131402003 -0500
> > 
> > Handling of mount --move in presense of shared mounts (see
> > Documentation/sharedsubtree.txt in the end of patch series
> > for detailed description).
> 
> This patch seems to be totally wrong.  It copies the mounts instead of
> moving them in the propagated cases.
> 
> Am I missing something?

Yes, you are.  We move a single subtree (which has no peers at all)
to mountpoint that gives propagation.  The subtree itself gets moved
to specified mountpoint; for the rest of points in propagation tree
of that mountpoint we have no choice but to create copies.
