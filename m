Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWGZHb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGZHb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWGZHb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:31:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:12944 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932398AbWGZHb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:31:27 -0400
Date: Wed, 26 Jul 2006 00:27:12 -0700
From: Greg KH <gregkh@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726072712.GC6249@suse.de>
References: <20060725203028.GA1270@kroah.com> <44C69819.8080908@superbug.co.uk> <44C6B269.4080607@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6B269.4080607@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 02:08:09AM +0200, Stefan Richter wrote:
> James Courtier-Dutton wrote:
> >What happens about the logging?
> >Surely one would want the output from one probe to be output into the
> >log as a block, and not mix the output from multiple simultaneous probes.
> 
> Use single-line printks were possible, or mutex-protected multiline 
> blocks where you really can't do without multiple lines of printks that 
> really cannot be separated. (Don't perform time consuming functions 
> within those mutexes; that would defeat the multithreaded probing...)
> 
> To adjust printks is only the beginning of what is to be done to adapt 
> single-threaded bus probes to multithreaded ones. There may be hidden 
> assumptions that rely on single-threaded execution.

Yeah, some drivers really don't like it, the ata_piix driver for example
had to be changed to keep it from thinking it was really being hotpluged
instead of the initial probe sequence.  Odds are there are lots of other
driver specific issues like this everywhere.  That's why it's a driver
specific flag, when the authors of the driver say it's ready, then it
will be enabled for that driver.

thanks,

greg k-h
