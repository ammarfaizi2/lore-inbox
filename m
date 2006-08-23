Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWHWJGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWHWJGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWHWJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:06:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:40396 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751461AbWHWJGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:06:37 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:06:26 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231050.13272.ak@suse.de> <44EC194E.6080606@vmware.com>
In-Reply-To: <44EC194E.6080606@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231106.26696.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 August 2006 11:01, Zachary Amsden wrote:
> Andi Kleen wrote:
> >> Yes, after discussion with Rusty, it appears that beefing up 
> >> stop_machine_run is the right way to go.  And it has benefits for 
> >> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
> >> extension modules to be loaded without having to deal with a debug 
> >> exception or NMI during module load/unload.
> >>     
> >
> > I'm still unclear where you think those debug exceptions will come from
> 
> kprobes set in the stop_machine code - which is probably a really bad 
> idea, but nothing today actively stops kprobes from doing that.

kprobes don't cause any debug exceptions. You mean int3?

Anyways this can be fixed by marking the stop machine code __kprobes

-Andi
