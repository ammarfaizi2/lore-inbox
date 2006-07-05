Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWGESSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWGESSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWGESSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:18:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51858 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964964AbWGESSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:18:41 -0400
Message-ID: <44AC027F.8050906@watson.ibm.com>
Date: Wed, 05 Jul 2006 14:18:39 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, Valdis.Kletnieks@vt.edu,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com> <449C6620.1020203@engr.sgi.com> <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com> <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com> <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org> <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org> <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org> <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com> <200606291230.k5TCUg45030710@turing-police.cc.vt.edu> <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com> <44A5EDE6.3010605@watson.ibm.com> <20060702215350.2c1de596.pj@sgi.com> <44A93179.2080303@watson.ibm.com> <44ABF4CE.2000604@engr.sgi.com>
In-Reply-To: <44ABF4CE.2000604@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Shailabh Nagar wrote:
> 
> 
>>Yes. If no one registers to listen on a particular CPU, data from tasks
>>exiting on that cpu is not sent out at all.
> 
> 
> Shailabh also wrote:
> 
> 
>>During task exit, kernel goes through each registered listener (small 
>>list) and decides which
>>one needs to get this exit data and calls a genetlink_unicast to each 
>>one that does need it.
> 
> 
> 
> Are we eliminating multicast taskstats data at exit time? 

Yes. Only unicasts to each listener now.

> A unicast
> exit data with cpumask will do for me, but just like to be sure where
> we are.

