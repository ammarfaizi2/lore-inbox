Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVCICWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVCICWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVCICWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:22:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:7580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262327AbVCICUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 21:20:55 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org>  <20050308090946.GA4100@in.ibm.com>
	 <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	 <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1110332642.6521.27.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Mar 2005 17:44:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 11:18, Badari Pulavarty wrote:
> > Andrew, please don't apply the original patch. We shouldn't even attempt
> > to submit IO beyond the filesize. We should truncate the IO request to
> > filesize. I will send a patch today to fix this.
> > 
> 
> Well, spoke too soon. This is an ugly corner case :( But I have
> a ugly hack to fix it :)
> 
> Let me ask you a basic question: Do we support DIO reads on a file
> which is not blocksize multiple in size ? (say 12K - 10 bytes) ?
> 
> What about the ones which are not 4K but 512 byte multiple ? (say 7K) ?
> 
> I need answer to those, to figure out how hard I should try to fix this.
> 
> Anyway, here is ugly version of the patch - which will limit the IO
> size to filesize and uses lower blocksizes to read the file (since
> the filesize is only 3K, it would go down to 512 byte blocksize).
> 

BTW, I got a compile error because the 'iov' parameter is
declared with 'const', so your patch is changing a read-only
value.  :(

Daniel

