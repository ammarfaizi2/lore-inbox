Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWFZLUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWFZLUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWFZLUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:20:23 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17503 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964962AbWFZLUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:20:23 -0400
Date: Mon, 26 Jun 2006 13:19:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Mike Grundy <grundym@us.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, dwilder@us.ibm.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060626111938.GC9418@osiris.boeblingen.de.ibm.com>
References: <20060626080910.GA9418@osiris.boeblingen.de.ibm.com> <20060626104945.GA1244@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626104945.GA1244@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 03:49:45AM -0700, Mike Grundy wrote:
> On Mon, Jun 26, 2006 at 10:09:10AM +0200, Heiko Carstens wrote:
> > > After reading your notes it's probably overkill doing the cs on each cpu, since
> > > the interrupt will discard the prefetched instructions.
> > 
> > Indeed. Another thing that should not be forgotten: it could be that the
> > whole kernel text segment resides in a shared read only segment. So it can
> > be shared by multiple z/VM guests.
> > In that case the cs instruction will fail. Looks like you need to write the
> > part that replaces the instruction in assembly and supply a fixup section
> > which in turn makes sure that -EFAULT is returned.
> 
> If it fails, won't it will generate a program interrupt, 5 (access exception)?

Yes, that's why you need a fixup section :)
