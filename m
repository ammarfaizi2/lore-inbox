Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWBXCok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWBXCok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWBXCok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:44:40 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:50855 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750861AbWBXCoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:44:39 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: Dave Jones <davej@redhat.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20060223202638.GD6213@redhat.com>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140707358.4672.67.camel@laptopd505.fenrus.org>
	 <200602231700.36333.ak@suse.de>
	 <1140713001.4672.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	 <43FE0B9A.40209@keyaccess.nl>
	 <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
	 <43FE1764.6000300@keyaccess.nl>  <20060223202638.GD6213@redhat.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Fri, 24 Feb 2006 11:44:15 +0900
Message-Id: <1140749055.2411.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 15:26 -0500, Dave Jones wrote:
> On Thu, Feb 23, 2006 at 09:13:24PM +0100, Rene Herman wrote:
>  > Linus Torvalds wrote:
>  > 
>  > >If you want to boot a 4MB machine with the suggested patch, you'd 
>  > >have to enable CONFIG_EMBEDDED (something you'd likely want to do 
>  > >anyway, for 4M machine), and turn the physical start address back
>  > >down to 1MB.
>  > 
>  > Okay. I suppose the only other option is to make "physical_start" a 
>  > variable passed in by the bootloader so that it could make a runtime 
>  > decision? Ie, place us at min(top_of_mem, 4G) if it cared to. I just 
>  > grepped for PHYSICAL_START and this didn't look _too_ bad.
>  > 
>  > I'm out of my league here though -- if I remember correctly from some 
>  > reading of the early bootcode I once did, the kernel set up some 
>  > temporary tables first to only cover the first few MB? If so, then I 
>  > guess it would be a significant change.
>  > 
>  > Seems a bit cleaner though than just hardcoding the address.
> 
> the kdump people were looking at making the kernel runtime relocatable
> at one point, which with my distro-vendor hat on, would be useful
> as it'd mean we could use the same kernel image for normal boot, and
> also for the 'kdump kernel'
The mkdump team has accomplished this ...

>   (Right now, we ship another set of
> kernels for each arch with a different PHYSICAL_START).
... so that we do not need to hard-code PHYSICAL_START. The dump capture
kernel is able to run from any memory address the host kernel reserves
for it. The are some limitations though:

- i386: the second kernel has to be loaded in low memory
- x86_64: the second kernel has to be loaded below 1GB (we are working
to move this limit to 4GB)

> (You wouldn't believe how much grief we get from the installer folks
>  for adding another set of kernel images to the ISOs).
> 
> I think that work stalled a while back though.

The mkdump team has been using runtime relocatable kernels for two years
and we are currently working on porting this functionality to kdump. I
was wondering if it would be accepted mainstream.

Regards,

Fernando

