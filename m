Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWCFP5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWCFP5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWCFP5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:57:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751837AbWCFP5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:57:03 -0500
Date: Mon, 6 Mar 2006 15:56:50 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 6/6] dm to use bd_claim_by_disk
Message-ID: <20060306155649.GB25317@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	device-mapper development <dm-devel@redhat.com>
References: <4408E33E.1080703@ce.jp.nec.com> <4408E638.9060704@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4408E638.9060704@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 07:58:32PM -0500, Jun'ichi Nomura wrote:
> This patch is part of dm/md sysfs dependency tree.
 
> +static int open_dev(struct dm_dev *d, dev_t dev, struct gendisk *holder)
> +static int upgrade_mode(struct dm_dev *dd, int new_mode, struct gendisk *holder)
> +static void close_dev(struct dm_dev *d, struct gendisk *holder)

Please pass the dm structure, struct mapped_device, around between dm functions
internally where you can, instead of struct gendisk.  (Every time the new 
parameter is passed it's wrapped with dm_disk(), so move the dm_disk() inside.)

Alasdair
-- 
agk@redhat.com
