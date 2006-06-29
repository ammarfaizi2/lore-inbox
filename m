Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933039AbWF2WOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbWF2WOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWF2WOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:14:48 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20199 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S933039AbWF2WOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:14:46 -0400
Message-ID: <44A450A1.4090202@watson.ibm.com>
Date: Thu, 29 Jun 2006 18:13:53 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com>	<20060629123338.0d355297.akpm@osdl.org>	<44A42D6D.6060108@watson.ibm.com> <20060629130046.c695c6c5.akpm@osdl.or!
 g>
In-Reply-To: <20060629130046.c695c6c5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>Yup...the per-cpu, high speed requirements are up relayfs' alley, unless 
>>Jamal or netlink folks
>>are planning something (or can shed light on) how large flows can be 
>>managed over netlink. I suspect
>>this discussion has happened before :-)
> 
> 
> yeah.

And now I remember why I didn't go down that path earlier. Relayfs is one-way
kernel->user and lacks the ability to send query commands from user space
that we need. Either we would need to send commands up through a separate interface
(even a syscall) or try and ensure that the exiting genetlink interface can
scale better with message volume (including throttling).

--Shailabh



