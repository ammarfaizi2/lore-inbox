Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTDDNxG (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTDDNtq (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:49:46 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:61452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263627AbTDDNdo (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:33:44 -0500
Date: Fri, 4 Apr 2003 14:45:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: fcorneli@elis.ugent.be
Cc: linux-kernel@vger.kernel.org, Frank.Cornelis@elis.rug.ac.be
Subject: Re: read actor
Message-ID: <20030404144512.E25147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	fcorneli@elis.ugent.be, linux-kernel@vger.kernel.org,
	Frank.Cornelis@elis.rug.ac.be
References: <Pine.LNX.4.44.0304031601080.3041-100000@tom.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304031601080.3041-100000@tom.elis.rug.ac.be>; from fcorneli@elis.ugent.be on Thu, Apr 03, 2003 at 04:14:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 04:14:05PM +0200, fcorneli@elis.ugent.be wrote:
> Hi,
> 
> When one uses do_generic_file_read to (in-kernel) read a file from the 
> page cache one has to give a read_actor as parameter. Suppose different 
> do_generic_file_read instances occur simultaneously, then how can a 
> shared file_read_actor differentiate between the different 
> do_generic_file_read instances that made a call to it?
> Shouldn't read_descriptor_t contain something like
> 	void *this_data;
> to make this possible?

do_generic_file_read is not an interface you are supposed to use, and any use
of it will lead to subtile races with filesystems that use the pagecache
but not plain generic_file_read.  See the ->sendfile operation in 2.5
for a proper fix.

