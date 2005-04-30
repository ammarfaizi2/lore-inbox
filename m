Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVD3OxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVD3OxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVD3OxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:53:24 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:8854 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261238AbVD3OxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:53:20 -0400
Date: Sat, 30 Apr 2005 10:53:06 -0400
To: Steve French <smfrench@austin.rr.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050430145306.GA22276@fieldses.org>
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427387FB.4030901@austin.rr.com>
User-Agent: Mutt/1.5.9i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 08:28:27AM -0500, Steve French wrote:
> Miklos Szeredi wrote:
> 
> >>>- network/userspace filesystems should be fine aswell
> >>>     
> >>>
> >>They should, but again I wonder if NFS with all it's complexity is
> >>being careful enough with what it accepts from the server.
> >>   
> >>
> That is the fun of trying to get our network filesystems up to the
> 20th century.  There is at lot more work that has to be done here, but
> it is gradually improving.  At least for cifs but probably for NFSv4
> (and possibly AFS) it is possible for the client to validate that the
> server is who it says it is, and both NFSv4 (actually the newer NFS
> RPC) and CIFS of course allow packet signing which helps, not sure if
> AFS allows packet signing.

None of this helps in the situation Miklos is considering, where the
attacker is a user on the client doing the mount.  So presumably the
user gets to choose a server under his/her control, and all the
authentication does is prove to the user that s/he got the right server,
which doesn't protect the kernel at all.

The only defense is auditing the client code's handling of data it
receives from the server.

--b.
