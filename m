Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWHDG23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWHDG23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHDG23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:28:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2822 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932229AbWHDG22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:28:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LtJIfUE/gqZipQkd/yAvOPUXCHuWZnCWq0yEHVVqYG60HnUEOx1B9Wg10i2xfYuK/vMNW3U6A13hU2UtUrKRa92w04tprbbLnTZgiK3cgga1YoIO6YgoOoC3dUKELv9uoJ+aIncd8Am2aiq1/wsAhhsDyFcEtOSMqK9Jh+nqg2Y=
Message-ID: <69304d110608032328r36bc0a6ase0a2dbf36d8cc519@mail.gmail.com>
Date: Fri, 4 Aug 2006 08:28:26 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Chris Wright" <chrisw@sous-sol.org>, "Andrew Morton" <akpm@osdl.org>,
       "Jeremy Fitzhardinge" <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, rusty@rustcorp.com.au, jlo@vmware.com,
       xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <20060804054002.GC11244@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com>
	 <20060803211850.3a01d0cc.akpm@osdl.org>
	 <20060804054002.GC11244@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Chris Wright <chrisw@sous-sol.org> wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > I must confess that I still don't "get" paravirtops.  AFACIT the VMI
> > proposal, if it works, will make that whole layer simply go away.  Which
> > is attractive.  If it works.
>
> Paravirtops is simply a table of function which are populated by the
> hypervisor specific code at start-of-day.  Some care is taken to patch
> up callsites which are performance sensitive.  The main difference is
> the API vs. ABI distinction.  In paravirt ops case, the ABI is defined at
> compile time from source.  The VMI takes it one step further and fixes
> the ABI.  That last step is a big one.
>
> There are two basic issues. 1) what is the interface between the kernel
> and the glue to a hypervisor. 2) how does one call from the kernel into
> the glue layer.
>
> Getting bogged down in #2, the details of the calling convention, is a
> distraction from the real issue, #1.  We are trying to actually find an
> API that is useful for multiple projects.  Paravirt_ops gives the
> flexibility to evolve the interface.

One feature I found missing at the paravirt patches is to allow the
user to forbid the use of paravirtualization of certain features (via
a bitmask on the kernel commandline for example) so that the execution
drops into the native hardware virtualization system. Such a feature
would provide a big upwards compatibility for the kernel<->hypervisor
system. The case for this would be needing to forcefully upgrade the
hypervisor due to security issues and finding out that the hypervisor
is  incompatible at the paravirtualizatrion level, then the user would
be at least capable of continuing to run the old kernel with the new
hypervisor until the compatibility is reached again.

BTW, what is the recommended distro or kernel setup to help testing
the latest paravirt patches? I've got a spare machine (with no needed
data) at hand which could be put to good use.

-- 
Greetz, Antonio Vargas aka winden of network
