Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbULTBDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbULTBDc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbULTBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:03:31 -0500
Received: from fsmlabs.com ([168.103.115.128]:10668 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261370AbULTBD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:03:29 -0500
Date: Sun, 19 Dec 2004 17:59:58 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <29495f1d04121818403f949fdd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>  <20041205232007.7edc4a78.akpm@osdl.org>
  <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com> 
 <20041206160405.GB1271@us.ibm.com>  <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
  <20041206192243.GC1435@us.ibm.com>  <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
  <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
 <29495f1d04121818403f949fdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004, Nish Aravamudan wrote:

> All of these schedule_timeout() calls are broken. They do not set the
> state before hand and therefore will return early. Since you're not
> checking for signals and there are no waitqueue events around the
> code, I'm assuming you can just use ssleep(1) instead of the current
> schedule_timeout() calls.

Returning early is fine (and will happen if the other processors are 
busy), we're spinning on a condition, but yes ssleep() could be used 
instead.

Thanks,
	Zwane

