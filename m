Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWJ0Ec0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWJ0Ec0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWJ0Ec0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:32:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:41261 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932274AbWJ0EcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:32:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=elYU0gbVSFO73H417mmAm89jkzW4MwKAbw06MjeFKJNZ0CRGjCUHTCVbkRtn9FkmsiTef4N9nUCc/a3pCffNXIBBKZw9vo/TES11CSuvmO8eElFYpWK5ILbr5BPALFV+yBtz0AnPf15RdzFP8cQXK2MQpwchZcBXSNg15tv21JQ=
Message-ID: <45418BCF.8080108@gmail.com>
Date: Fri, 27 Oct 2006 00:32:15 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, proski@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org>
In-Reply-To: <20061025205923.828c620d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> May be so.  But this patch was supposed to print a helpful taint message to
> draw our attention to the fact that ndis-wrapper was in use.  The patch was
> not intended to cause gpl'ed modules to stop loading (or if is was, that
> effect was concealed from yours truly).
>   
It's an unintended side effect of recent per-module-taint changes which
exposed the special nature of ndiswrapper & driverloader taints. Here's
where it went wrong:

Florin Malita wrote:
> No need to keep 'license_gplok' around anymore, it should be equivalent
> to !(taints & TAINT_PROPRIETARY_MODULE).
>   

That turns out to be true for every module under the sun except
ndiswrapper & driverloader which are singled out and treated
differently: their proprietary taint has nothing to do with their license.

Randy's patch looks like a reasonable compromise to get them going again
- the alternative being the reintroduction of license_gplok or some
equivalent per-module flag just to support 2 hardcoded exceptions where
GPL incompatibility and proprietary tainting are not correlated.

---
fm
