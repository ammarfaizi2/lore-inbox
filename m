Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFXUBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFXUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:01:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2551 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262267AbTFXUBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:01:01 -0400
Subject: Re: Large backwards time steps panic 2.5.73
From: john stultz <johnstul@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1056485244.1825.173.camel@mulgrave>
References: <1056472020.2085.81.camel@mulgrave>
	 <1056484203.1033.192.camel@w-jstultz2.beaverton.ibm.com>
	 <1056485244.1825.173.camel@mulgrave>
Content-Type: text/plain
Organization: 
Message-Id: <1056485215.1032.197.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 13:06:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 13:07, James Bottomley wrote:
> On Tue, 2003-06-24 at 14:50, john stultz wrote:
> > On Tue, 2003-06-24 at 09:26, James Bottomley wrote:
> > > The above trace is from a HP PA-RISC machine running 2.5.73-pa1.
> > 
> > Hmm. Odd. What is the HZ frequency on this machine? 
> 
> On the kernel with the panic, 100.  If I build a 64 bit kernel (which I
> haven't done for .73 yet) I'll get 1000

Ok I'd be curious if it occurs there as well

The only bits the patch should touch are used in adjtimex, and adjtimex
is very limited on how much it can adjust time. If you're a year off or
whatever, its more likely ntpdate is calling stime/settimeofday. 

Could you boot w/o ntp starting up, then manually run  "ntpdate -b
<server>" to see if that causes it as well? 

thanks
-john


