Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVIQOq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVIQOq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 10:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVIQOq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 10:46:56 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:35981 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S1750872AbVIQOqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 10:46:55 -0400
Message-ID: <432C2BF1.1040100@keyaccess.nl>
Date: Sat, 17 Sep 2005 16:45:05 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <200506011643.42073.david-b@pacbell.net> <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz> <200506011917.14678.david-b@pacbell.net> <429F075F.7030804@keyaccess.nl> <42F3E95B.4050704@keyaccess.nl> <20050917023639.B49481FF9E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050917023639.B49481FF9E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>Hi David. Has there been any progress on this issue?
>>
>>(thread at http://marc.theaimsgroup.com/?t=111749614000002&r=1&w=2)
> 
> 
> Taking a look at that, I found one case that _might_ explain it.  That
> scenario could crop more (or less) based on loads and timings, and I've
> suspected that the VIA chips have significantly different timings for
> certain things.  This patch handles that case differently, just expecting
> the unlink completion code (later) to restart the schedule.
> 
> I sanity tested this, but that's all.

[ snip ]

> -	if (!head->qh_next.qh) {
> +	if (!head->qh_next.qh && !ehci->reclaim) {

Thanks, but unfortunately no change. That is, still have that "Async" 
status flag toggling on and off in /sys/class/usb_host/usb?/registers 
(and the ~ 8MB/s drop in IDE throughput).

Rene.

