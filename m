Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWHINVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHINVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHINVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:21:23 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:5232 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750766AbWHINVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:21:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fMMxTD4iipxUM1loQygAB/WAi4abSNazJSBF3jVIJyhBBIH9FOFOIyqag2XPSoiuEwAtFFNvdovwvVUEYKZvH3xYoHLA5wHuNYQqSpO8WJqX9k8Xjpcb/198jsAZGFlu8MXV1XJjRlD2ezb++20CEsOQsYebIP89TnqzyDumU3Q=
Message-ID: <6bffcb0e0608090621q488eada3h1edae21e94e6997f@mail.gmail.com>
Date: Wed, 9 Aug 2006 15:21:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ravikiran G Thirumalai" <kiran@scalex86.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@muc.de>, "Jan Beulich" <jbeulich@novell.com>,
       "Alok Kataria" <alok.kataria@calsoftinc.com>
In-Reply-To: <20060809062159.GA3829@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	 <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
	 <20060808140511.def9b13c.akpm@osdl.org>
	 <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
	 <20060808143751.42f8d87c.akpm@osdl.org>
	 <6bffcb0e0608081511x17508f89j60705bf74e09e820@mail.gmail.com>
	 <20060808164210.edb10cdc.akpm@osdl.org>
	 <20060809062159.GA3829@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/08/06, Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> On Tue, Aug 08, 2006 at 04:42:10PM -0700, Andrew Morton wrote:
> > On Wed, 9 Aug 2006 00:11:38 +0200
> > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> >
> > ah-hah, thanks.  The oopsing statement was added by
> > slab-fix-lockdep-warnings.patch.
> >
> > I guess we can fix this by whacking another #ifdef CONFIG_NUMA in there but
> > I don't think that's how we want to address this.
> >
> > We've been moving towards making the NUMA slab code work OK in a non-NUMA
> > build by setting the NUMA-specific fields to NULL and simply blowing a few
> > cycles at runtime to avoid many tens of ifdefs (it's that bad).
> >
> > Here, we should have had either l3==NULL or l3->alien==NULL, but that has
> > been violated, hence the crash.
> > Kiran, could you take a look please?  The 0x01020304 is interesting...
>
> Eeesh, because on SMP,  alloc_alien_cache returns 0x01020304 instead of
> NULL, And it returns 0x01020304 because CPU_UP_PREPARE fails if
> alloc_alien_cache returns NULL.  NUMA and non NUMA slab should be able to
> work even without alien caches, currently that doesn't seem to be the case.
> We are working on that.  In the meanwhile, the following patch should
> fix the oops due to locdep annotation.
>
> Thanks,
> Kiran
>
> Fix oops due to alien cache locdep annotation on non NUMA configurations.
> A plain alien != NULL won't work as l3->alien is initialized with
> 0x01020304ul

Bug fixed, thanks.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
