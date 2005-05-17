Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVEQSf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVEQSf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEQSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:35:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:23247 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261898AbVEQSfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:35:10 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: dino@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517170824.GA3931@in.ibm.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave>  <20050517170824.GA3931@in.ibm.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 13:34:53 -0500
Message-Id: <1116354894.4989.42.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 22:38 +0530, Dinakar Guniguntala wrote:
> May  9 12:03:32 llm09 kernel:   Vendor: IBM CORP  Model: GEM312 V002       Rev: 4.1b
> May  9 12:03:32 llm09 kernel:   Type:   Processor                          ANSI SCSI revision: 02

OK, that's roughly what I was expecting.  These processor chips tend to
be rather basic when it comes to rates and widths.

The root cause, I think, is that the aic7xxx isn't starting out at async
narrow for the first inquiry (because the original DV code I removed did
this, and I didn't add an equivalent back).  The latest aic7xxx patch
should sort this out.

So, to get all of these changes, could you start with vanilla linus
kernel 2.6.12-rc4 (or tree based on this, but not -mm which already has
some of the SCSI tree included) and then apply the SCSI patch at

http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff

and see if it works?

Thanks,

James


