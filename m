Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUE2Ikx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUE2Ikx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUE2Ikx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:40:53 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:64633 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUE2Iko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:40:44 -0400
Message-ID: <40B84C85.8010207@yahoo.com.au>
Date: Sat, 29 May 2004 18:40:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matthias Schniedermeyer <ms@citd.de>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: MM patches (was Re: why swap at all?)
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> (pages with program/library code, data of e.g. your Mozilla, etc),
> please submit a report to lkml. VM gurus said more than once
> that they _want_ to fix things, but need to know how to reproduce.

Yep.

Thanks to everyone's input I was able to test and adapt my mm work.
It is hopefully at a stage where it can have wider testing now. It
is stable on my SMP system under very heavy swapping, but the usual
caution applies.

Test is 4 x cat 8GB > /dev/null (aggregate 100-200MB/s!) while in X,
with xterms and mozilla open browsing and grepping kernel tree, etc.

Plain 2.6.7-rc1-mm1 swapped 200MB then completely froze up the system
within 9 seconds of starting the read load. Things remained fairly
responsive with my patch applied. A bit of swap out, but very little
swap in, which is good. The entire 32GB went through the pagecache no
problem.

A couple of concurrent mkisofs's writing 4 GB isos don't seem to be
any problem either with the patched kernel. Haven't tried plain -mm
yet.

http://www.kerneltrap.org/~npiggin/nickvm-267r1m1.gz

It is a cocktail of cleanups, simplification, and enhancements. The
main ones that applie here is my split active lists patch (search
archives for details), and explicit use-once logic.

Known issue: page reclaim can get a little bit lumpy (ie lots of
memory freed up at once), but that is just a matter of teaching
things not to bite off massive chunks at a time when it starts
hitting memory pressure.
