Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932975AbWFZTtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWFZTtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbWFZTtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:49:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:43740 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932975AbWFZTtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:49:00 -0400
Date: Mon, 26 Jun 2006 14:48:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Jones <davej@redhat.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu
Subject: Re: [PATCH] s390: fix duplicate export of overflow{ug}id
Message-ID: <20060626194812.GD32035@sergelap.austin.ibm.com>
References: <20060626193141.GB32035@sergelap.austin.ibm.com> <20060626193704.GF18599@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626193704.GF18599@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Jones (davej@redhat.com):
> On Mon, Jun 26, 2006 at 02:31:41PM -0500, Serge E. Hallyn wrote:
>  > overflowuid and overflowgid were exported twice.  Remove the export
>  > from s390_ksyms.c
> 
> There's a gotcha with this.  in kernel/sys.c, we only export those
> symbols if CONFIG_UID16 is set.  iirc, there was some part of
> arch/s390 that expected to use those symbols even if it wasn't set.
> 
> Does everything still link with that option both set and unset ?

It does on my partition; near as I can tell the only use of overflowuid
is in compat_linux.c, which is always compiled in.

Nevertheless a #ifndef CONFIG_UID16 is probably more appropriate?

thanks,
-serge
