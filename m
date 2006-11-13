Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753808AbWKMCIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbWKMCIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 21:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbWKMCIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 21:08:23 -0500
Received: from mx1.suse.de ([195.135.220.2]:22206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753808AbWKMCIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 21:08:22 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Date: Mon, 13 Nov 2006 03:07:56 +0100
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
References: <20061111100038.6277efd4.akpm@osdl.org> <1163340998.3293.131.camel@laptopd505.fenrus.org> <20061112214540.GB31649@redhat.com>
In-Reply-To: <20061112214540.GB31649@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130307.57110.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andi has a nice patch in the suse kernel which adds heuristics to disable
> apic on systems where it isn't likely to work.  It DTRT in at least
> one problem case that I know of.   The actual fall-out from enabling
> 'run SMP kernels on UP i686' for FC6 has mostly been a non-event.
> Literally a handful of cases, that will likely all get caught and worked
> around by Andi's patch or similar.

I haven't pushed that recently because i was busy with other things, but
needs to be revisited yes.

One broken case that still happens is that the patch assumes working
SMBIOS. When there is no year in SMBIOS it will turn off APIC because
it assumes it is a very old system. But sometimes new systems who would
like APIC have illegal or broken SMBIOS year. On very new systems it isn't
a problem again because those tend to have multiple cores.

That could be probably a bit more clever. It's always difficult to
navigate around all kinds of BIOS bugs.

-Andi
