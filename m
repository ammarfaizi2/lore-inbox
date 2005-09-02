Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVIBSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVIBSQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIBSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:16:18 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:38628 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750788AbVIBSQS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:16:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E3Dv3W/GpH89QjttEJcgTAbBPyvOIIr65kojNjtlEV/qiDsdrXE8/KQpQ7sj88hD8gXK/f4TC5z1ubVZZpPLqp3HW3F76FXZbyCxDxFOga5eNPfhfgiHt5AHKrXSFExrt1195XcB7mQnbA/OH5OwwgGHhFvUvfazhmJuyJ/gn+I=
Message-ID: <ed5aea430509021116233eeb39@mail.gmail.com>
Date: Fri, 2 Sep 2005 11:16:10 -0700
From: david mosberger <dmosberger@gmail.com>
Reply-To: David.Mosberger@acm.org
To: Grant Grundler <iod00d@hp.com>
Subject: Re: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting (for ia64)
Cc: Brent Casavant <bcasavan@sgi.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050902164828.GA10587@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431694DB.90400@jp.fujitsu.com>
	 <20050901172917.I10072@chenjesu.americas.sgi.com>
	 <20050902164828.GA10587@esmail.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Grant Grundler <iod00d@hp.com> wrote:
> On Thu, Sep 01, 2005 at 05:45:54PM -0500, Brent Casavant wrote:
> ...
> > The first is serialization of all I/O reads and writes.  This will
> > be a severe problem on systems with large numbers of PCI buses, the
> > very type of system that stands the most to gain in reliability from
> > these efforts.  At a minimum any locking should be done on a per-bus
> > basis.
> 
> The lock could be per "error domain" - that would require some
> arch specific support though to define the scope of the "error domain".

I do not think the basic inX/outX and readX/writeX operations should
involve spinlocks.  That would be really nasty if an MCA/INIT handler
had to call them, for example...

> > The second is the raw performance penalty from acquiring and dropping
> > a lock with every read and write.  This will be a substantial amount
> > of activity for any I/O-intensive system, heck even for moderate I/O
> > levels.
> 
> Sorry - I think this is BS.
> 
> Please run mmio_test on your box and share the results.
> mmio_test is available here:
>         svn co http://svn.gnumonks.org/trunk/mmio_test/

Reads are slow, sure, but writes are not (or should not).

  --david
-- 
Mosberger Consulting LLC, voice/fax: 510-744-9372,
http://www.mosberger-consulting.com/
35706 Runckel Lane, Fremont, CA 94536
