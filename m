Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUB0Qfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUB0Qfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:35:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18656 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263039AbUB0Qef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:34:35 -0500
Date: Fri, 27 Feb 2004 08:33:41 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-ID: <20040227163341.GB1424@beaverton.ibm.com>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20040226235412.GA819@phunnypharm.org> <20040226171928.750f5f6f.akpm@osdl.org> <20040226173743.2bf473b4.akpm@osdl.org> <20040227030428.GA707@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227030428.GA707@phunnypharm.org>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins [bcollins@debian.org] wrote:
>  static void scsi_host_cls_release(struct class_device *class_dev)
>  {
> +	down(&host_num_lock);
> +	idr_remove(&allocated_hosts, class_to_shost(class_dev)->host_no);
> +	up(&host_num_lock);
>  	put_device(&class_to_shost(class_dev)->shost_gendev);
>  }
>  

Should the idr_remove be done in scsi_host_dev_release instead? We
really should not make this number available until everyone is done with
this host.

-andmike
--
Michael Anderson
andmike@us.ibm.com

