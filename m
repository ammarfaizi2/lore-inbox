Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWF0SmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWF0SmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWF0Sl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:41:59 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:7104 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030259AbWF0Sl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=inISVPvwwu6u62UezdyrdDU2I5tNYwHsgd66nukgpx68c10m44trYUn/xA9TNAEDGHU8dv7JFDm7ifyEFCtdOLV+8lZAlhGzNw1eqEHFKy+uhSi4IXFeknyq95RG2apcyPqfTMGaARDhzhBItZtcw/7ZPdHF7N1hXoj484I+XWI=
Message-ID: <6bffcb0e0606271141o22077d69ya26fa6926e5524a1@mail.gmail.com>
Date: Tue, 27 Jun 2006 20:41:58 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Shailabh Nagar" <nagar@watson.ibm.com>
Subject: Re: [PATCH] delay accounting taskstats interface: send tgid once locking fix
Cc: akpm@osdl.org, "Arjan van de Ven" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, balbir@in.ibm.com,
       jlan@engr.sgi.com
In-Reply-To: <44A162F0.3060808@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net>
	 <1151421336.5217.28.camel@laptopd505.fenrus.org>
	 <44A15483.30308@watson.ibm.com> <44A1576C.8090307@watson.ibm.com>
	 <44A162F0.3060808@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/06, Shailabh Nagar <nagar@watson.ibm.com> wrote:
> Use irqsave variants of spin_lock for newly introduced tsk->signal->stats_lock
> The lock is nested within tasklist_lock as part of release_task() and hence
> there is possibility of a AB-BA deadlock if a timer interrupt occurs while
> stats_lock is held.
>
> Thanks to Arjan van de Ven for pointing out the lock bug.
> The patch conservatively converts all use of stats_lock to irqsave variant
> rather than only the call within taskstats_tgid_free which is the function
> called within tasklist_lock protection.
>
> Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
>

Problem solved, thanks.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
