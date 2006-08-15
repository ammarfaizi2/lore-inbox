Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWHOTbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWHOTbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWHOTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:31:08 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:41622 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030475AbWHOTbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:31:06 -0400
Subject: Re: [RFC] [PATCH] file posix capabilities
From: Nicholas Miell <nmiell@comcast.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
In-Reply-To: <20060815122026.GA7422@vino.hallyn.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	 <20060814220651.GA7726@sergelap.austin.ibm.com>
	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
	 <20060815020647.GB16220@sergelap.austin.ibm.com>
	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
	 <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>
	 <20060815122026.GA7422@vino.hallyn.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 12:31:02 -0700
Message-Id: <1155670262.2432.4.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 07:20 -0500, Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serge@hallyn.com):
> > > Make it an arbitrary length bitfield with a defined byte order (little
> > > endian, probably). Bits at offsets greater than the length of the
> > > bitfield are defined to be zero. If the kernel encounters a set bit that
> > > it doesn't recognizes, fail with EPERM. If userspace attempts to set a
> > > bit that the kernel doesn't recognize, fail with EINVAL.
> > > 
> > > It's extensible (as new capability bits are added, the length of the
> > > bitfield grows), backward compatible (as long as there are no unknown
> > > bits set, it'll still work) and secure (if an unknown bit is set, the
> > > kernel fails immediately, so there's no chance of a "secure" app running
> > > with less privileges than it expects and opening up a security hole).
> > 
> > Sounds good.
> > 
> > The version number will imply the bitfield length, or do we feel warm
> > fuzzies if the length is redundantly encoded in the structure?
> 
> nm, 'encoded in the structure' clearly is silly.
> 

There isn't really a version number, just recognized and unrecognized
capability bits. If you wanted, you could use a single byte to give a
binary CAP_DAC_OVERRIDE, with capability bits 8-30 being "stored" in
not-present bytes and therefore assumed to be zero.

-- 
Nicholas Miell <nmiell@comcast.net>

