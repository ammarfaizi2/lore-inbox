Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWCUPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWCUPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWCUPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:54:59 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:56742 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751183AbWCUPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:54:58 -0500
Subject: Re: [PATCH] scsi: properly count the number of pages in
	scsi_req_map_sg()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dan Aloni <da-x@monatomic.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
       dror@xiv.co.il
In-Reply-To: <20060321083830.GA2364@localdomain>
References: <20060321083830.GA2364@localdomain>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 09:54:54 -0600
Message-Id: <1142956494.4377.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a good email to discuss on the scsi list:
linux-scsi@vger.kernel.org; whom I've added to the cc list.

On Tue, 2006-03-21 at 10:38 +0200, Dan Aloni wrote:
> Improper calculation of the number of pages causes bio_alloc() to
> be called with nr_iovecs=0, and slab corruption later.
> 
> For example, a simple scatterlist that fails: {(3644,452), (0, 60)},
> (offset, size). bufflen=512 => nr_pages=1 => breakage. The proper
> page count for this example is 2.

Such a scatterlist would likely violate the device's underlying
boundaries and is not legal ... there's supposed to be special code
checking the queue alignment and copying the bio to an aligned buffer if
the limits are violated.  Where are you generating these scatterlists
from?

James




