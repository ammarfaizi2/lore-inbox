Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbSJQTwK>; Thu, 17 Oct 2002 15:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJQTwK>; Thu, 17 Oct 2002 15:52:10 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28679 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261794AbSJQTwJ>; Thu, 17 Oct 2002 15:52:09 -0400
Date: Thu, 17 Oct 2002 20:58:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
Subject: Re: [PATCH] pre-decoded wchan output
Message-ID: <20021017205803.A7555@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, riel@conectiva.com.br
References: <1034882043.1072.589.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1034882043.1072.589.camel@phantasy>; from rml@tech9.net on Thu, Oct 17, 2002 at 03:14:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:14:02PM -0400, Robert Love wrote:
> Linus,
> 
> Attached patch implements a /proc/#/wchan which provides a pre-decoded
> wchan via kallsyms.  I.e.,
> 
> 	[15:05:06]rml@phantasy:~$ cat /proc/1228/wchan
> 	wait4
> 
> Which is damn cool to me and will let ps(1) grab wchan information
> without having to parse System.map.  It also means procps will not need
> System.map.
> 
> If CONFIG_KALLSYMS is enabled, /proc/#/wchan exists and exports the
> pre-decoded symbol name.  The old wchan value in /proc/#/stat is
> hard-coded to zero.
> 
> If CONFIG_KALLSYMS is not enabled, /proc/#/wchan does not exist to
> conserve memory.  In that case, the old wchan field in /proc/#/stat will
> export the usual wchan address.
> 
> This will not break procps, however the wchan field will be zero without
> an updated version if CONFIG_KALLSYMS is set.  That is fine as 2.5
> requires an updated procps anyhow.  If CONFIG_KALLSYMS is not set,
> things are unchanged.

Can't you just left the old, nuerical one in even if CONFIG_KALLSYMS
ise set?  One ifdef less and far less surprises..

