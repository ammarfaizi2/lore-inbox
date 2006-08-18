Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWHRX3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWHRX3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWHRX3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:29:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7738 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422646AbWHRX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:29:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=JlY/nDthDN4BgjGlU/CMrOI1XqJcUgOXKsr8CyOHuMzPDtP1lvIQL6PgWymFF+FQ5wvaraClrBxYJb3EjWyVOT8nxAsjORQ5p90NX+ms9T8LKcRyqH6NU7XDTZtsyHT7eFhNu5E0MZotrPb6mpF4dnBG3aEqCLrCNftnGx5C73g=
Date: Sat, 19 Aug 2006 03:29:10 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kai Petzke <wpp@marie.physik.tu-berlin.de>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
Message-ID: <20060818232910.GA5221@martell.zuzino.mipt.ru>
References: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org> <44E63476.201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44E63476.201@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 05:43:18PM -0400, Jeff Garzik wrote:
> Alan Stern wrote:
> >I'd like to lodge a bitter complaint about the return codes used by
> >queue_work() and related functions:
> >
> >	Why do the damn things return 0 for error and 1 for success???
> >	Why don't they use negative error codes for failure, like
> >	everything else in the kernel?!!
>
> It's a standard programming idiom:  return false (0) for failure, true
> (non-zero) for success.  Boolean.

There are at least 3 idioms:

1) return 0 on success, -E on fail¹.

	rv = foo();
	if (rv < 0)
		...

2) return 1 on YES, 0 on NO.
3) return valid pointer on OK, NULL on fail.

	p = kmalloc();
	if (!p)
		...

#2 should only be used if condition in question is spelled nice:

	if (license_is_gpl_compatible())
		...
	else
		ATI_you_can_fuck_off_too();

The question is into which category queue_work() fails.

> Certainly the kernel often uses the -errno convention, but it's not a rule.

¹ BSD returns E* where E* is negative and thus avoids "return E*;" bugs (where E
  is positive).

