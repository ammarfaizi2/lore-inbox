Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWAEVpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWAEVpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWAEVpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:45:52 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:40855 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932229AbWAEVpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:45:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z2HGSxk8GqvvmRe3xZ+bMluXZPpqFt0esJ85f5sP5yT4gCDTLYI1qu6txvMwoiEcJUpb8SEI/sqILfSzyxxIx3EkxMS0UMnwOcfKlZHVJxUq/pWEtUkfbSvCWGvhVaZADUWcWLkr9MOJicA9nn5pEVPn1vTLm418KcZvAmrbKHU=
Message-ID: <12c511ca0601051345pee8d8wc735507d361fa65e@mail.gmail.com>
Date: Thu, 5 Jan 2006 13:45:50 -0800
From: Tony Luck <tony.luck@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] fix workqueue oops during cpu offline
Cc: linux-kernel@vger.kernel.org, Ben Collins <bcollins@debian.org>,
       Andrew Morton <akpm@osdl.org>, ashok.raj@intel.com
In-Reply-To: <20060105045810.GE16729@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105045810.GE16729@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Nathan Lynch <ntl@pobox.com> wrote:
> This is where things go wrong -- any_online_cpu() now gets 1, not 0.
> In queue_work, the cpu_workqueue_struct at per_cpu_ptr(wq->cpu_wq, 1) is
> uninitialized.

Same issue on ia64 when I tried to add Ashok' s patch to allow
removal of cpu0 (BSP in ia64-speak).  Ashok told me that this fix
solves the problem for us too.

-Tony
