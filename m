Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVK0GcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVK0GcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 01:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVK0GcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 01:32:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46052 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750898AbVK0GcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 01:32:20 -0500
Date: Sun, 27 Nov 2005 06:32:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] shared mounts: save mount flag space
Message-ID: <20051127063216.GC27946@ftp.linux.org.uk>
References: <E1EfJfC-00016e-00@dorka.pomaz.szeredi.hu> <E1EfJnm-00017H-00@dorka.pomaz.szeredi.hu> <E1EfK2o-0001AK-00@dorka.pomaz.szeredi.hu> <20051126215509.073cb957.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126215509.073cb957.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 09:55:09PM -0800, Andrew Morton wrote:
> > -	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
> > -		retval = do_change_type(&nd, flags);
> > +	else if (flags & MS_PROPAGATION)
> > +		retval = do_change_type(&nd, flags & MS_REC, data_page);
> >  	else if (flags & MS_MOVE)
> >  		retval = do_move_mount(&nd, dev_name);
> >  	else
> 
> But I don't know how much trauma this would cause.  Hasn't util-linux
> already been patched with the new mount flags?
> 
> If it has, and if it uses the same names for these options, the patched
> mount(8) just won't work.
> 
> The proposed new mount options should be documented somewhere.
> 
> Anyway, I'll let Ram&Al decide on this proposal.

It's
	a) palliative
	b) ugly

Let's face it, mount(2) ABI is getting past its shelf life already.
We'll need saner replacement (not mixing action with the flags and
being really typed) anyway, so let's not introduce more kludges into
mount(2) already messy situation - it's not worth the effort.
