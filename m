Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWALE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWALE75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWALE74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:59:56 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:27324 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030261AbWALE7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:59:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lt5hwUe8A1QqoxKqlAY3vodiBklqHO2zd0KQAc6AzzqyerEtWak+Qy+6uZ03IBcDY183IYwKZf6M8RPHjlS50aT+npd6cVG3LvwS35hx44tYbYA23KrGw4ndk5wjrydje8HPuECOzHtnbZ2MpFbmGoaapHFC3Dluwlk1cTkFKPU=
Message-ID: <4807377b0601112059je92091ch73f3788aeca452ce@mail.gmail.com>
Date: Wed, 11 Jan 2006 20:59:50 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com>
	 <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com>
	 <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/06, Grant Coady <gcoady@gmail.com> wrote:
> On Tue, 10 Jan 2006 16:24:28 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
>
> >On 1/9/06, Grant Coady <gcoady@gmail.com> wrote:
> >> Hi there,
> >>
> >> While testing for a different issue on a box with two e100 NICs I noticed
> >> that interrupt and other accounting are accumulated to the first e100 NIC.
> >
> >are the two e100's on the same broadcast domain?  if they are you
> >might actually be transferring all traffic on eth0
>
> You ignore the fact these two NICs work as expected on 2.6.15
> and on 2.4.32 when e100 driver is compiled in, for the same
> hardware and test.
> >
> >e100 doesn't track its own interrupt counts, the kernel does that for us.
>
> What further testing would you like?  Also, you ignore the all
> zeroes ifconfig accounting for the second NIC, and that the
> accounting was also accumulated to the first e100 along with
> interrupts.

okay mea culpa, I guess I didn't see you say that.
It sounds like the netdev structs are somehow overlapped.

> Anyway the solution is simple: modular e100 is borked on 2.4,
> compiled in is okay.

modular e100 2.X is borked, right? if you have a moment could you try
the 3.X e100 driver from sourceforge?
(http://prdownloads.sf.net/e1000) it should work fine on 2.4 and I
haven't heard any reports of icky stats.

thanks for your testing and bug reports.

Jesse
