Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVGHEhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVGHEhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVGHEhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:37:18 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:25425 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262598AbVGHEhQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:37:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gybXzRArGhffdrTk9I0+RKimjS1ZtoMAV466fcDC6uRTK4wdiqx1H+odYtg+CCx8+ejeIAbXfziqkeUOCNrIshYBrJP6KVD9kBZJj+AKdUEZYIc5LAiE4B7CKMS00vbiSXOiPAAHZSr9bmEWkl5YN2do8Lo079VbRNoxIWy/sB0=
Message-ID: <ed5aea4305070721373480591d@mail.gmail.com>
Date: Thu, 7 Jul 2005 21:37:15 -0700
From: david mosberger <dmosberger@gmail.com>
Reply-To: David.Mosberger@acm.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 2.6.13-rc1 07/10] IOCHK interface for I/O error handling/detecting
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <42CB6961.2060508@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB6961.2060508@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/05, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> wrote:

>    - could anyone write same barrier for intel compiler?
>      Tony or David, could you help me?

I think it might be best to make ia64_mca_barrier() a proper
subroutine written in assembly code.  Yes, that costs some time, but
we're talking about wasting 1,000+ cycles just to consume the value
read via readX(), so the call-overhead is actually overlapped and
completely trivial.

  --david
