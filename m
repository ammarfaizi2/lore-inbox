Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWCCXVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWCCXVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWCCXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:21:04 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:17919 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932498AbWCCXVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:21:03 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Doug Thompson <dthompson@lnxi.com>, arjan@infradead.org
Subject: Re: [PATCH 1/15] EDAC: switch to kthread_ API
Date: Fri, 3 Mar 2006 15:20:29 -0800
User-Agent: KMail/1.5.3
Cc: bluesmoke-devel@lists.sourceforge.net, hch@lst.de,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4408050A0200003600000CC8@zoot.lnxi.com>
In-Reply-To: <4408050A0200003600000CC8@zoot.lnxi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031520.29855.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 07:57, Doug Thompson wrote:
> Currently the timer event code performs two operations:
>
>   1) ECC polling and
>   2) PCI parity polling.
>
> I want to split those from each other, so each can have a seperate cycle
> rate (also adding a sysfs cycle control for the PCI parity timing in
> addition to the existing ECC cycle control).

Yes, this sounds like a good idea.  Using schedule_delayed_work() to
independently implement each polling cycle, we should be able to get
rid of the EDAC kernel thread.
