Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWBHWEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWBHWEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWBHWEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:04:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54658 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751120AbWBHWEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:04:36 -0500
Date: Wed, 8 Feb 2006 14:11:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Bernd Schubert <bernd-schubert@gmx.de>
Cc: Chris Wright <chrisw@sous-sol.org>, John M Flinchbaugh <john@hjsoft.com>,
       reiserfs-list@namesys.com, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
Message-ID: <20060208221124.GN30803@sorel.sous-sol.org>
References: <200602080212.27896.bernd-schubert@gmx.de> <200602081314.59639.bernd-schubert@gmx.de> <20060208205033.GB22771@shell0.pdx.osdl.net> <200602082246.15613.bernd-schubert@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602082246.15613.bernd-schubert@gmx.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bernd Schubert (bernd-schubert@gmx.de) wrote:
> Er, you mean /proc/fs/reiserfs/{partition}/on-disk-super?

Yup.

> bernd@bathl ~>grep attrs_cleared /proc/fs/reiserfs/hda6/on-disk-super
> flags:  1[attrs_cleared]

> > 2) does mount -o attrs ... make a difference?
> 
> Yes, 2.6.13 now makes the same trouble. No difference with 2.6.15.3. 
> I played with mount -o noattrs, this makes no difference with 2.6.13, but has 
> some effects to 2.6.15.3. Creating files in /var/run is possible again, 
> lsattr gives "lsattr: Inappropriate ioctl for device While reading flags 
> on /var/run", but deleting files in /var/run is still impossible (still 
> rather bad for the init-scripts).

Yes, that's what I thought.  There's still some backward logic in there.
noattrs vs. attrs triggers whether the code path that's patched in
2.6.15.3 is taken.  I'll dig a bit more, but hopefully the reiserfs folks 
can fix this for us.

thanks,
-chris
