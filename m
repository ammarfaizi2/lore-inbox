Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbTJPXUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJPXUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:20:31 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:58630 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263255AbTJPXU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:20:26 -0400
Date: Thu, 16 Oct 2003 16:20:20 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016232020.GC29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016162926.GF1663@velociraptor.random>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 06:29:26PM +0200, Andrea Arcangeli wrote:
> Hi Jeff,
> 
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > Josh and others should take a look at Plan9's venti file storage method 
> > -- archival storage is a series of unordered blocks, all of which are 
> > indexed by the sha1 hash of their contents.  This magically coalesces 
> > all duplicate blocks by its very nature, including the loooooong runs of 
> > zeroes that you'll find in many filesystems.  I bet savings on "all 
> > bytes in this block are zero" are worth a bunch right there.
> 
> I had a few ideas on the above.
> 
> if the zero blocks are the problem, there's a tool called zum that nukes
> them and replaces them with holes. I use it sometime, example:

With the exception of NUL blocks i doubt there is much
savings at any level below the file.  That is, only a tiny
fraction of files that are not fully duplicate of one
another will share many aligned blocks.

Now detecting files that are duplicates and linking them in
some way might be a useful in a low-priority daemon.  But
the links created would have to be sure to preserve them as
seperate inodes so that overwrites break the loose link but
not the user-created hardlink.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
