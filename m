Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269802AbUJMTDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269802AbUJMTDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269796AbUJMTDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 15:03:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57546 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269797AbUJMTBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 15:01:51 -0400
Date: Wed, 13 Oct 2004 14:01:36 -0500
To: Oliver Neukum <oliver@neukum.org>
Cc: James Bruce <bruce@andrew.cmu.edu>, bert hubert <ahu@ds9a.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc4] USB && mass-storage && disconnect broken semantics
Message-ID: <20041013190136.GD12237@austin.ibm.com>
References: <20041011120701.GA824@outpost.ds9a.nl> <416B9436.3010902@andrew.cmu.edu> <200410121224.44910.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410121224.44910.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 12:24:44PM +0200, Oliver Neukum was heard to remark:
>  
> > With *nix, most data only gets written at unmount, so the only way this 
> > can "sanely" work is for mounts you haven't written to.  That case is of 
> 
> This is not a law of nature. You can mount sync as well. That, of course,
> sucks in terms of performance and wear. A reasonable compromise
> would be to do sync on close.
> Supermount did this years ago.

As a practical matter, sync-on-file-close should solve most 
of the practical problem of data corruption if the device is 
yanked before being onmounted.  However, when I read 
'man 2 open' there is no O_SYNC_ON_CLOSE.  

Similarly 'man 8 mount' doesn't list any option -o synconclose

It sure would be nice to be able to set up a sync-on-file-close
in the hotplug equiv of /etc/fstab for USB devices ... 

(When I think of sync-on-file-close, I don't mean 'global sync 
when the file is closed', I mean 'sync only that file's data and 
metadata only when the file is closed'.  That way, you don't slow 
down systems doing a lot of i/o on other, unrelated files)

--linas
