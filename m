Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVEKJAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEKJAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVEKJAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:00:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64426 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261933AbVEKI7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:59:22 -0400
Date: Wed, 11 May 2005 09:59:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, 7eggert@gmx.de, smfrench@austin.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050511085921.GB24841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
	smfrench@austin.rr.com, linux-kernel@vger.kernel.org
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 11:22:48AM +0200, Miklos Szeredi wrote:
> >  - virtual filesystems exporting kernel data are obviously safe as
> >    they enforce permissions no matter who mounted them.  (actually we'd
> >    need to check for some odd mount options)
> 
> Maybe sysadmin doesn't want to let users see /sys for example.  How
> would you disable it if users can mount it themselfes?  OK, you can
> disable user mounts completely, but that's probably not fine grained
> enough for some.

the sysadmin shouldn't do that.  sysfs is needed for proper operation
in a modern system and there's nothing to hid in there.

> >  - block-based filesystems should be safe as long as the mounter has
> >    access to the underlying block device
> 
> Not true if user controls the baking device (e.g. loopback).

I didn't say we should make using the loopback driver a non-privilegued
operation.

> Most
> block based filesystems are probably unsafe at the moment, because not
> enough consistency checking is done at runtime.  Are things like
> non-cyclic directory graphs ensured by all filesystems?  My guess is
> not.  See also Linus' comment about the state of the iso9660
> filesystem:
> 
>   http://lwn.net/Articles/128744/

It just mean that a) the system admin should be careful what drivers are
loaded and b) we need to audit block based filesystems better.

Note that in many current distributions users can mount iso9660 filesystems
through user mount hacks already.  Accessible to everyone and in the global
namespace.

