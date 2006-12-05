Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968214AbWLEODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968214AbWLEODi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968216AbWLEODi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:03:38 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:33776 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968214AbWLEODh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:03:37 -0500
Date: Tue, 5 Dec 2006 09:02:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, magnus.damm@gmail.com,
       fastboot@lists.osdl.org, ebiederm@xmission.com,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 00/02] kexec: Move segment code to assembly files
Message-ID: <20061205140252.GA7959@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061205133757.25725.96929.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205133757.25725.96929.sendpatchset@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:37:57PM +0900, Magnus Damm wrote:
> kexec: Move segment code to assembly files
> 
> The following patches rearrange the lowlevel kexec code to perform idt,
> gdt and segment setup code in assembly on the code page instead of doing
> it in inline assembly in the C files.
> 

I don't think we should be doing this. I would rather prefer code to
keep in C for easier debugging, readability and maintenance. 

> Our dom0 Xen port of kexec and kdump executes the code page from the
> hypervisor when kexec:ing into a new kernel. Putting as much code as
> possible on the code page allows us to keep the amount of duplicated
> code low.
> 

Is Xen going upstream now? I heard now lhype+KVM seems to be the way. 
Even if it is required, we should do it once Xen goes in.

You have already moved page table setup code to assembly and we should
be getting rid of that code too. 

I would rather live with duplicated code than moving more code in assembly
which can be written in C. Understanding and debugging assembly code
is such a big pain.

Thanks
Vivek
