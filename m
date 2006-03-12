Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWCLPfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWCLPfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWCLPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:35:48 -0500
Received: from fmr22.intel.com ([143.183.121.14]:14797 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751006AbWCLPfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:35:48 -0500
Date: Sun, 12 Mar 2006 07:35:25 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Suresh B Siddha <suresh.b.siddha@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on 2.6.16-rc6
Message-ID: <20060312073524.A9213@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl> <20060311210353.7eccb6ed.akpm@osdl.org> <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl> <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>; from olel@ans.pl on Sun, Mar 12, 2006 at 02:05:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 02:05:00PM +0100, Krzysztof Oledzki wrote:
> 
> 
> On Sun, 12 Mar 2006, Andrew Morton wrote:
> 
> > Krzysztof Oledzki <olel@ans.pl> wrote:
> >>
> >> On Sat, 11 Mar 2006, Andrew Morton wrote:
> >>
> >> > Krzysztof Oledzki <olel@ans.pl> wrote:
> >> >>
> >> >> After upgrading to 2.6.16-rc6 I noticed this strange message:
> >> >>
> >> >>  More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
> >> >>  Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
> >> >>
> >> >> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so with
> >> >>  totoal of 4 logical CPUs).
> >> >
> >> > Please send full dmesg output for the failing kernel, thanks.
> >>  Attached.
> >>
> >> > Which is the most-recently-tested kernel which behaved correctly?
> >>  2.6.15.6
> >
> > OK, thanks.  I assume the machine's working OK?
> 
> Yes. So far no problems, only this warning.
> 
> > From my reading, you have CONFIG_HOTPLUG_CPU enabled and the machine has an
> > APIC.
> That is correct.
> 
> > I'd expect that lots of people would hit that warning but for some
> > reason they don't - possibly because most APICs don't have sufficiently
> > high version numbers?
> >

Actually, this warning should be seen on many other systems on well. We
use the bigsmp when there _or_ more than 8 CPUs or CPU_HOTPLUG is used.
So, in that sense the message is wrong, it should also have CPU_HOTPLUG in
there. Or we should make CPU_HOTPLUG depend on GENERIC_ARCH or auto select
GENERIC_ARCH with hotplug at the CONFIG level.

Will defer to Ashok for a proper fix.

Thanks,
Venki
