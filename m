Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVCIUBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVCIUBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVCIUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:00:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:5564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262145AbVCITyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:54:54 -0500
Date: Wed, 9 Mar 2005 11:53:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: pbadari@us.ibm.com, daniel@osdl.org, sebastien.dugue@bull.net,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050309115348.2b86b765.akpm@osdl.org>
In-Reply-To: <20050309152047.GA4588@in.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	<20050307223917.1e800784.akpm@osdl.org>
	<20050308090946.GA4100@in.ibm.com>
	<1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	<1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
	<1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
	<1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
	<20050309040757.GY27331@ca-server1.us.oracle.com>
	<20050309152047.GA4588@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
>  > 	Solaris, which does forcedirectio as a mount option, actually
>  > will do buffered I/O on the trailing part.  Consider it like a bounce
>  > buffer.  That way they don't DMA the trailing data and succeed the I/O.
>  > The I/O returns actual bytes till EOF, just like read(2) is supposed to.
>  > 	Either this or a fully DMA'd number 4 is really what we should
>  > do.  If security can only be solved via a bounce buffer, who cares?  If
>  > the user created themselves a non-aligned file to open O_DIRECT, that's
>  > their problem if the last part-sector is negligably slower.
> 
>  If writes/truncates take care of zeroing out the rest of the sector
>  on disk, might we still be OK without having to do the bounce buffer
>  thing ?

We can probably rely on the rest of the sector outside i_size being zeroed
anyway.  Because if it contains non-zero gunk then the fs already has a
problem, and the user can get at that gunk with an expanding truncate and
mmap() anyway.


