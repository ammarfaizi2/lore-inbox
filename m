Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVC3G1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVC3G1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVC3G1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:27:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29335 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261696AbVC3G1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:27:32 -0500
Date: Tue, 29 Mar 2005 22:25:37 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: jlan@engr.sgi.com, johnpol@2ka.mipt.ru, guillaume.thouvenin@bull.net,
       akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       efocht@hpce.nec.com, linuxram@us.ibm.com, gh@us.ibm.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329222537.647d3150.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112092197.5243.80.camel@uganda>
	<20050329090304.23fbb340.pj@engr.sgi.com>
	<4249C418.5040007@engr.sgi.com>
	<Pine.LNX.4.62.0503292200550.30657@twinlark.arctic.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean wrote:
> by the time do_exit() occurs the parent may have disappeared

I don't think Jay was disagreeing with this.  I think he agrees
that there is to be collected:
 1) the classic bsd accounting data, in do_exit
 2) the fork time <parent pid, child pid> by some mechanism at
	fork time (perhaps just not the fork_connect mechanism)
 3) some additional data to be harvested at exit time, for CSA

I suspect you two are just tripping over words to describe this.

However, this does expose another possibility.  Record the original
forking parent pid in another task_struct field at fork time (didn't
someone else have a 'bio_pid' patch to this affect?), and add that task
struct value to the list of additional items to be written out, at exit
time.

I was skeptical that CBUS could have zero impact on fork, but recording
one more word in the task struct at fork gets about as close to zero
impact as one can get on fork.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
