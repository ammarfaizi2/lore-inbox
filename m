Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUIUSLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUIUSLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUIUSLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:11:18 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:55743 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267979AbUIUSLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:11:13 -0400
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject
	interfacesupport
From: Alex Williamson <alex.williamson@hp.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Yu, Luming" <luming.yu@intel.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921172546.GA7077@thunk.org>
References: <3ACA40606221794F80A5670F0AF15F84059309EF@pdsmsx403>
	 <1095735738.3920.29.camel@mythbox>  <20040921172546.GA7077@thunk.org>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 12:10:52 -0600
Message-Id: <1095790252.24751.41.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 13:25 -0400, Theodore Ts'o wrote:
> On Mon, Sep 20, 2004 at 09:02:18PM -0600, Alex Williamson wrote:
> > > But, some AML methods are risky to be called directly from user space,
> > > Not only because the side effect of its execution, but also because
> > > it could trigger potential AML method bug or interpreter bug, or even
> > > architectural defect.  All of these headache is due to the AML method
> > >  is NOT intended for being used by userspace program.
> > 
> >    I've made an attempt to hide the most obvious dangerous methods, but
> > undoubtedly, there will be some.  Why are we any more likely to hit an
> > AML method bug, interpreter bug or architectural bug by having a
> > userspace interface?  
> 
> As long as the userspace interfaces are only available to the root
> filesystem, I'm not sure it's worth it to hide any of the methods.
> It's added complexity, and in any case, root can do untold amounts of
> damage by writing to /dev/mem, trying to upload firmware to IDE
> drives, etc., etc., etc.

   Yes, very true.  I think the difference is that in my current
implementation, objects are evaluated on read.  This makes it terribly
easy to do the wrong thing "Hmm, I wonder what that file does... oops".
Evaluating on write would set the bar a little higher, but still has
some of the same issues.  In theory, I definitely agree, the interface
shouldn't need to hide anything.  (I'm sure there are ACPI firmware
folks frightened by that idea)  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

