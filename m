Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVIIUFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVIIUFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbVIIUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:05:20 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:626 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030432AbVIIUFS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:05:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bmoa8Dm7O3aAmQ84qzWlpFmakHRBJo+236ly0VUUwe6yllW8dAvLeVB5ZrrAlekefD7g7Ger+T5b8jAPP4UnTf8Q855jAjBE923AJFIB9/ly+9csdFLXn4dpIReXulPmoLuI0umM7mts2DKdCoTyEpEbjn191ynb/81vIXsj3Fw=
Message-ID: <29495f1d050909130525f13c7a@mail.gmail.com>
Date: Fri, 9 Sep 2005 13:05:17 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: [PATCH 2.6.13 9/14] sas-class: sas_expander.c Expander discovery and configuration
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4321E553.6040001@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4321E553.6040001@adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

<snip>


> --- linux-2.6.13-orig/drivers/scsi/sas-class/sas_expander.c     1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.13/drivers/scsi/sas-class/sas_expander.c  2005-09-09 11:14:29.000000000 -0400

<snip>

+static int sas_ex_general(struct domain_device *dev)

<snip>

+                       set_current_state(TASK_INTERRUPTIBLE);
+                       schedule_timeout(5*HZ);

Can you use msleep_interruptible() here? I don't see wait-queues in
the immediate vicinity. If not, and you're going for the normal -mm
route (and from there to mainline), can you use
schedule_timeout_interruptible(), please?

Thanks,
Nish
