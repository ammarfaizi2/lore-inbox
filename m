Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUE2HjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUE2HjF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 03:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUE2HjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 03:39:05 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:41488 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262459AbUE2HjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 03:39:02 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Date: Sat, 29 May 2004 10:31:02 +0300
User-Agent: KMail/1.5.4
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 01:28, Bernd Eckenfels wrote:
> In article <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> you wrote:
> >> The benchmark involved was ls.  It took several seconds.  If I ran it
> >> again in 5 seconds or so, it was fine.  Much longer and it would take
> >> several seconds again.  Sounds like pages getting evicted in LRU order.
> >
> > By what magic system can know that you are going to do ls again
> > in 2 minutes?
>
> The problem is more about the blocks cp touches, less  about predicting the
> ls workload.
>
> > cp should use fadvise() and say that it _really_ does not need those
> > pages.
>
> Yes, indeed. On the other hand the sequential read could be detected by the
> kernel, too.

Looks like it was. ls' read was sequential, too, so it did not get any
advantage. If you can definitely show that streaming io
(say, cat hugefile >/dev/null) flushes _non_ sequentially read data
(pages with program/library code, data of e.g. your Mozilla, etc),
please submit a report to lkml. VM gurus said more than once
that they _want_ to fix things, but need to know how to reproduce.
--
vda

