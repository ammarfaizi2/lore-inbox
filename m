Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWG0Hjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWG0Hjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWG0Hjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:39:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:12944 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWG0Hjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:39:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=quN4B/xcEb+P4ynv6awtqH5dW1qgERd9OgW1lHtnfcPMUTdDEfXDLX5JhzbmIZ1rmOg6jmp6sLeih9AYJb47wooIXy81djYkIqmcAYv2smmZeGZgJ0GPemySDWI1pEIV69WErvRvnUN99r9PCpQ0LKL2wPJ4ciDaJYqlcB7TRqQ=
Date: Thu, 27 Jul 2006 09:38:38 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: BUG() on apm resume in 2.6.18-rc2
Message-ID: <20060727073838.GA12586@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060727033819.GA368@fieldses.org> <20060726231049.e9a0346e.akpm@osdl.org> <20060727062932.GA32598@leiferikson.gentoo> <20060727000856.f75d2603.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727000856.f75d2603.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 27, 2006 at 12:08:56AM -0700, Andrew Morton wrote:
> (please always do reply-to-all)

Oh, sorry. Sometimes mutt doesn't recognize mails belonging to a list.

> That was an easy one - it crashed at
> 
> EIP is at mcheck_init+0x4/0x80
> 
> right at the start of mcheck_init(), so it had to be the access of
> mce_disabled.
> 
> It accessed the address c0729c38:
> 
> BUG: unable to handle kernel paging request at virtual address c0729c38
> 
> and the code dump shows an access to that address.
> 
> And the only way in which an access to a global variable of this nature can
> oops is if that variable has been unmapped from the kenrel address space. 
> We unmap (and reuse) the __init memory, so it had to be a sectioning bug.

The fix was clear to me, though. After seeing it, I could imagine what
went wrong.

Hannes
