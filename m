Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVD3I35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVD3I35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVD3I34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:29:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261153AbVD3I3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:29:54 -0400
Date: Sat, 30 Apr 2005 09:29:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, 7eggert@gmx.de, smfrench@austin.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050430082952.GA23253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
	smfrench@austin.rr.com, linux-kernel@vger.kernel.org
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 10:14:07AM +0200, Miklos Szeredi wrote:
> > Except that we don't have the concept of a mount owner at the VFS level
> > right now, because everyone is adding stupid suid wrapper hacks instead
> > of trying to fix the problems for real.
> 
> Having a mount owner is not a problem.  Having a good policy for
> accepting mounts is rather more so, according to some:
> 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=107705608603071&w=2
> 
> Just a little taste of what that policy would involve:
> 
>   - global limit on user mounts

I don't think we need that one.

>   - possibly per user limit on mounts

Makes sense as an ulimit, that way the sysadmin can easily disable the
user mount feature aswell.

>   - acceptable mountpoints (unlimited writablity is probably a good minimum)

Yupp.

>   - acceptable mount options (nosuid, nodev are obviously not)

noexecis a bit too much, so the above look good.

>   - filesystems "safe" to mount by users

what filesystem do you think is unsafe?

 - virtual filesystems exporting kernel data are obviously safe as
   they enforce permissions no matter who mounted them.  (actually we'd
   need to check for some odd mount options)

 - block-based filesystems should be safe as long as the mounter has
   access to the underlying block device

 - network/userspace filesystems should be fine aswell

