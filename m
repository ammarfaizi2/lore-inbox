Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWDMINh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWDMINh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWDMINh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:13:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWDMINg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:13:36 -0400
Date: Thu, 13 Apr 2006 01:13:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>
Subject: Re: 2.6.17-rc1-mm1
Message-Id: <20060413011303.668fe5c1.akpm@osdl.org>
In-Reply-To: <20060413073958.GB9428@osiris.boeblingen.de.ibm.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060413073958.GB9428@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> > +md-dm-reduce-stack-usage-with-stacked-block-devices.patch
> >  MD update.
> 
> Any chance to see this merged? I think this one is pending for quite a while.

Last time I broached it with Alasdair (10 Jan) he said

  I can see nothing wrong with this in principle.

  For device-mapper at the moment though it's essential that, while the
  bio mappings may now get delayed, they still get processed in exactly the
  same order as they were passed to generic_make_request().

  My main concern is whether the timing changes implicit in this patch
  will make the rare data-corrupting races in the existing snapshot code
  more likely.  (I'm working on a fix for these races, but the unfinished
  patch is already several hundred lines long.)

  It would be helpful if some people on this mailing list would test this
  patch in various scenarios and report back.


yes, it has been around for rather a while.
