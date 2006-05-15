Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWEOW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWEOW26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWEOW26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:28:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965268AbWEOW25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:28:57 -0400
Date: Tue, 16 May 2006 08:28:04 +1000
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups
Message-ID: <20060516082804.F5598@wobbly.melbourne.sgi.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com>; from pbadari@us.ibm.com on Mon, May 15, 2006 at 02:23:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badari,

On Mon, May 15, 2006 at 02:23:26PM -0700, Badari Pulavarty wrote:
> This patch cleans up generic_file_*_read/write() interfaces.
> Christoph Hellwig gave me the idea for this clean ups.
> 
> In a nutshell, all filesystems should set .aio_read/.aio_write
> methods and use do_sync_read/ do_sync_write() as their .read/.write 

I know its not something you're introducing here, but the naming
convention do_sync_read/do_sync_write is pretty confused (with it
not actually being a sync write and all, in the usual case).
Any chance that could be renamed to something thats a bit clearer,
maybe generic_file_non_aio_read and generic_file_non_aio_write?
There don't seem to be many callsites (so not a huge change) and
it'd seem a good time to do it, alongside these other changes.

> methods. This allows us to cleanup all variants of generic_file_*
> routines.
> 
> Final available interfaces:
> 
> generic_file_aio_read() - read handler
> generic_file_aio_write() - write handler
> generic_file_aio_write_nolock() - no lock write handler

thanks!

--
Nathan
