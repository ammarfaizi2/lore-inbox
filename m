Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVCWKgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVCWKgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCWKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:36:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:42434 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261518AbVCWKgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:36:23 -0500
Subject: Re: Query: Kdump: Core Image ELF Format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1111552017.3604.78.camel@localhost.localdomain>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	 <1111552017.3604.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 16:06:13 +0530
Message-Id: <1111574173.4756.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 13:26 +0900, Fernando Luis Vazquez Cao wrote:
> Hi all.
> 
> On Tue, 2005-03-08 at 18:20 +0530, vivek goyal wrote:
> > Core image ELF headers are prepared before crash and stored at a safe
> > place in memory. These headers are retrieved over a kexec boot and final
> > elf core image is prepared for analysis. 
> 
> Regarding the preparation of the ELF headers, I think we should also
> take into consideration hot-plug memory and create appropriate
> mechanisms to deal with it.
> 
> Assuming that both insertion and removal of memory trigger a hotplug
> event that is subsequently handled by the relevant hotplug agent(*), the
> latter could be modified so that, on successful memory onlining,
> additional PT_LOAD headers are created and tucked in a safe place
> together with the others.

I think, re-loading the panic kernel in such event should be an easier
solution. Current kexec system call interface does not allow to read
back already stored segments, which is necessary to append new PT_LOAD
headers to the existing program header list and update ELF header.

> 
> Since ELF headers are to be prepared by kexec a new option could be
> added to it, so that we can call kexec from a hotplug script to carry
> out the aforementioned tasks.
> 
> Any thoughts or suggestions on this?
> 
> (*) The last patches posted by Dave Hansen already support memory
> onlining from an /etc/hotplug script.
> 
> Fernando
> 
> 
> 

