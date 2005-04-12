Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVDLQsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVDLQsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDLQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:46:49 -0400
Received: from mail.shareable.org ([81.29.64.88]:27552 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262472AbVDLQpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:45:11 -0400
Date: Tue, 12 Apr 2005 17:45:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412164501.GB14149@mail.shareable.org>
References: <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org> <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu> <20050412161303.GI10995@mail.shareable.org> <E1DLOO0-0001xj-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLOO0-0001xj-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Yes, for NFSv2, this test in nfs_permssion():
> > 
> > 	if (!NFS_PROTO(inode)->access)
> > 		goto out;
> 
> I've seen that, I just thought that was for some broken servers not
> for all NFSv2 servers.
> 
> Anyway that's been fixed in NFSv3, so obviously the "permission
> checking on both sides" wasn't optimal :)
> 
> > And for either version of NFS, if the uid and gid are non-zero, and
> > the permission bits indicate that an access is permitted, then the
> > client does not consult the server for permission.
> 
> Where's that?  I see no such check.

	/*
	 * Trust UNIX mode bits except:
	 *
	 * 1) When override capabilities may have been invoked
	 * 2) When root squashing may be involved
	 * 3) When ACLs may overturn a negative answer */
	if (!capable(CAP_DAC_OVERRIDE) && !capable(CAP_DAC_READ_SEARCH)
	    && (current->fsuid != 0) && (current->fsgid != 0)
	    && error != -EACCES)
		goto out;

-- Jamie
