Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTETEwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 00:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTETEws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 00:52:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:40903 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263572AbTETEwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 00:52:47 -0400
Subject: Re: userspace irq balancer
From: Dave Hansen <haveblue@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "David S. Miller" <davem@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
In-Reply-To: <20030520034622.GK8978@holomorphy.com>
References: <200305191314.06216.pbadari@us.ibm.com>
	 <1053382055.5959.346.camel@nighthawk>
	 <20030519221111.P7061@devserv.devel.redhat.com>
	 <1053382943.4827.358.camel@nighthawk>
	 <1053401130.6830.3.camel@rth.ninka.net>
	 <20030520034622.GK8978@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053407030.13207.253.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 22:03:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 20:46, William Lee Irwin III wrote:
> On Mon, May 19, 2003 at 08:25:31PM -0700, David S. Miller wrote:
> > The in-kernel stuff MUST go.  It went in because "some benchmark went
> > faster", but with no "why" describing why it might have improved
> > performance.  We KNOW it absolutely sucks for routing and firewall
> > applications.  The in-kernel bits were all a shamans dance, with zero
> > technical "here is why this makes things go faster" description
> > attached.  If I remember properly, the changelog message when the
> > in-kernel irq balancing went in was of the form "this makes some
> > specweb run go faster".
> 
> Absolutely. Not to mention the code for the in-kernel algorithm has
> historically broken i386 ports using certain modes of Intel's
> interrupt controllers.

OK, I just went and actually looked at the code again.  After
suppressing my gag reflex, I started to remember all of the problems
we've had with it, including fixing it for Intel's own clustered APIC
mode. 

Does anyone have a patch to tear it out already?  Is the current proc
interface acceptable, or do we want a syscall interface like wli
suggests?

-- 
Dave Hansen
haveblue@us.ibm.com

