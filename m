Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263534AbTETDde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTETDde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 23:33:34 -0400
Received: from holomorphy.com ([66.224.33.161]:27883 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263534AbTETDdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 23:33:33 -0400
Date: Mon, 19 May 2003 20:46:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Arjan van de Ven <arjanv@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <20030520034622.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Gerrit Huizenga <gh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Andrew Morton <akpm@digeo.com>,
	Keith Mannthey <mannthey@us.ibm.com>
References: <200305191314.06216.pbadari@us.ibm.com> <1053382055.5959.346.camel@nighthawk> <20030519221111.P7061@devserv.devel.redhat.com> <1053382943.4827.358.camel@nighthawk> <1053401130.6830.3.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053401130.6830.3.camel@rth.ninka.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 08:25:31PM -0700, David S. Miller wrote:
> The in-kernel stuff MUST go.  It went in because "some benchmark went
> faster", but with no "why" describing why it might have improved
> performance.  We KNOW it absolutely sucks for routing and firewall
> applications.  The in-kernel bits were all a shamans dance, with zero
> technical "here is why this makes things go faster" description
> attached.  If I remember properly, the changelog message when the
> in-kernel irq balancing went in was of the form "this makes some
> specweb run go faster".

Absolutely. Not to mention the code for the in-kernel algorithm has
historically broken i386 ports using certain modes of Intel's
interrupt controllers.

Far better would be to validate that the affinity specified is feasible
to program into the interrupt controller in a system call and leave the
algorithm to userspace.


-- wli
