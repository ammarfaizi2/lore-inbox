Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWKCUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWKCUaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbWKCUap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:30:45 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:37852 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1753524AbWKCUao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:30:44 -0500
Subject: Re: [PATCH 1/1] security: introduce fs caps
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: 20060906182719.GB24670@sergelap.austin.ibm.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061103200011.GA2206@sergelap.austin.ibm.com>
References: <20061103175730.87f55ff8.chris@friedhoff.org>
	 <20061103200011.GA2206@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 03 Nov 2006 15:29:57 -0500
Message-Id: <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 14:00 -0600, Serge E. Hallyn wrote:
> Quoting chris friedhoff (chris@friedhoff.org):
> > The patch applies cleanly , compiles and runs smoothly against 2.6.18.1.
> > 
> > I'm running slackware-current with a 2.6.18.1 kernel on an ext3
> > filesystem.
> > 
> > Background why I use the patch:
> > With 2.6.18 to create a tuntap interface CAP_NET_ADMIN is required.
> > Qemu uses tuntap to create a tap interface as a virtual net interface.
> > Instead now running qemu with root privileges to give it the right
> > to create a tap interface, i granted qemu with the help of the patch and
> > Kaigai Kohei's userspace tools the cap-net_admin capability. So qemu
> > runs again without root privilege but has now the right to create the
> > tap interface.
> > 
> > Thanks for the patch. It reduces my the need of suid-bit progs.
> > It should be given a spin in -mm.
> 
> One question is, if this were to be tested in -mm, do we want to keep
> this mutually exclusive from selinux through config, or should selinux
> stack on top of this?

Given that SELinux already stacks with capability and you aren't using
the security fields (last I looked), it would seem trivial to enable
stacking with fscaps (just add a few secondary_ops calls to the SELinux
hooks, right?).

-- 
Stephen Smalley
National Security Agency

