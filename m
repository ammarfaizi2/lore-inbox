Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVBUVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVBUVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVBUVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 16:52:59 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:17390 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262141AbVBUVw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 16:52:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IH9KpO8LNxGKdxwVNWRR77M+rFOPNLUow68rJtuyCdRvwWvSvVHxGGcmQtGefxIu72b4gVQnuwT+J78dRKIZCPhdnfIGr1LPnkpvcF2t2Fo0aSXviaMk1EoywlA0EENOgTzu63vbHdJCYV/h+GANYpy8uG6Fyn82Ccue/XVNOyU=
Message-ID: <29495f1d0502211352776cfb36@mail.gmail.com>
Date: Mon, 21 Feb 2005 13:52:56 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Martin Hicks <mort@wildopensource.com>
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       raybry@sgi.com
In-Reply-To: <20050221192721.GB26705@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050214154431.GS26705@localhost>
	 <20050214193704.00d47c9f.pj@sgi.com>
	 <20050221192721.GB26705@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 14:27:21 -0500, Martin Hicks
<mort@wildopensource.com> wrote:
> 
> Hi,
> 
> I've made a bunch of changes that Paul suggested.  I've also responded
> to his concerns further down.  Paul correctly pointed out that this
> patch uses some helper functions that are part of the cpusets patch.  I
> should have mentioned this before.

<snip>

> This patch introduces a new sysctl for NUMA systems that tries to drop
> as much of the page cache as possible from a set of nodes.  The
> motivation for this patch is for setting up High Performance Computing
> jobs, where initial memory placement is very important to overall
> performance.

<snip>

> +       /* wait for the kernel threads to complete */
> +       while (atomic_read(&num_toss_threads_active) > 0) {
> +               __set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(10);
> +       }

<snip>

Would it be possible to use msleep_interruptible() here? Or is it a
strict check every 10 ticks, regardless of HZ? Could a comment be
inserted indicating
which is the case?

Thanks,
Nish
