Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWJTQ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWJTQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJTQ0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:26:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:53140 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932268AbWJTQ0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:26:46 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="149554855:sNHT844837462"
Date: Fri, 20 Oct 2006 09:26:22 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: [patch] libata: use correct map_db values for ICH8
Message-Id: <20061020092622.f564da61.kristen.c.accardi@intel.com>
In-Reply-To: <453891AD.70704@gmail.com>
References: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
	<453891AD.70704@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 18:06:53 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Hello, Kristen.
> 
> Kristen Carlson Accardi wrote:
> > Use valid values for ICH8 map_db.  With the old values, when the 
> > controller was in Native mode, and SCC was 1 (drives configured for
> > IDE), any drive plugged into a slave port was not recognized.  For
> > Combined Mode (and SCC is still 1), 2 is a value value for MAP.map_value,
> > and needs to be recognized.
> > 
> > Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> Do you guys have doc update related to this?  The doc and spec update 
> still indicate that MAP value is reserved to 00b.  Anyways, if you say 
> that's right...
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 
> -- 
> tejun
As far as I know, this has always been documented.
The datasheet is located here:
http://developer.intel.com/design/chipsets/datashts/313056.htm

Indicates that 10b is valid for combined mode.  Make sure you are looking
at device 31 function 2 - for 31 function 5 it is hardwired to 00b, but
for function 2, it can be 00 or 10.  This was not very clear, so it's
easy to understand how this could have been misunderstood.  See 
section 11.1.33 in the notes, or do a search on "combined mode" through
the doc, and you'll see that MV can be 10b when SCC is 01 on device 31
function 2.
