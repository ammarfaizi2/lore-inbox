Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUESFHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUESFHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 01:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUESFHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 01:07:30 -0400
Received: from ASYNC13-9.NET.CS.CMU.EDU ([128.2.188.77]:60290 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263743AbUESFH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 01:07:29 -0400
Date: Wed, 19 May 2004 01:08:01 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: invalidate_inode_pages2
Message-ID: <20040519050801.GA9605@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040519001520.GO3044@dualathlon.random> <20040518172718.773d32c1.akpm@osdl.org> <20040519005106.GP3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519005106.GP3044@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 02:51:06AM +0200, Andrea Arcangeli wrote:
> On Tue, May 18, 2004 at 05:27:18PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > Something broke in invalidate_inode_pages2 between 2.4 and 2.6, this
> > > causes malfunctions with mapped pages in 2.6.
> > 
> > What is the malfunction?
> 
> From Olaf Kirch
> 
>  -      single application on NFS client opens file and maps it.
>         No-one else has this file open. File contains "zappa\n",
>         and the test app stats it once a second and reports size and
>         contents.
>         len=6, data=7a 61 70 70 61 0a
>  -      on the NFS server, I do "echo frobnorz > file"
>  -      after a while, the test app on the client reports
>         len=10, data=7a 61 70 70 61 0a

I'm mostly just curious, what exactly happens when a second process
opens and mmaps the file at this point? Will it also see the new length
with the old data, or will that invalidate the mapping and pull the new
data off of the server?

Also what happens if the process had a shared mapping and dirtied the
page (f.i. it wrote a byte to to offset 0) but the update hasn't yet
been written back, will it end up committing the (stale) data from the
local copy of the page but with the updated length=10 back to the server?

Jan

