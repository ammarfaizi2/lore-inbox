Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWDZCbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWDZCbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWDZCbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:31:40 -0400
Received: from xenotime.net ([66.160.160.81]:12782 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932337AbWDZCbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:31:39 -0400
Date: Tue, 25 Apr 2006 19:34:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: minyard@acm.org, alan@lxorguk.ukuu.org.uk,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       steven.carbonari@intel.com, soo.keong.ong@intel.com,
       zhenyu.z.wang@intel.com
Subject: Re: Problems with EDAC coexisting with BIOS
Message-Id: <20060425193405.0ee50691.rdunlap@xenotime.net>
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
References: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 16:25:59 -0700 Gross, Mark wrote:

> 
> How about printing nothing like it used too?
> 
> See attached.  
> 
> Signed-off-by: Mark Gross

Hi Mark,

This small patch will need some cleaning up:

1.  Signed-off-by: Mark Gross <mark.gross@intel.com>

2.  Try not to use attachments.  If you must, then make the attachment
	type be text instead of octet-stream.

3.  No need to init to 0:
+static int force_function_unhide = 0;

4.  Typos:

+	/* check to see if device 0 function 1 is enbaled if it isn't we
                                                  enabled; it it isn't, we
+	 * assume the BIOS has reserved it for a reason and is expecting
+	 * exclusive access, we take care to not violate that assumption and
                                          not to violate
+	 * fail the probe. */

5.  indentation, typos, and at least one trailing space:

+	if (!force_function_unhide && !(stat8 & (1 << 5))) {
+		printk(KERN_INFO "contact your bios vendor to see if the " 
                                  Contact your BIOS
+		"E752x error registers can be safely un-hidden\n");
		^indent one more tab

---
~Randy
