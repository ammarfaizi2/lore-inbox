Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUCIVOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUCIVOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:14:43 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:14541
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262203AbUCIVOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:14:40 -0500
Message-ID: <404E33A7.6070800@redhat.com>
Date: Tue, 09 Mar 2004 13:14:15 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc/ppc64 and x86 vsyscalls
References: <1078708647.5698.196.camel@gaston> <404D7AC3.9050207@redhat.com> <1078830318.9746.3.camel@gaston>
In-Reply-To: <1078830318.9746.3.camel@gaston>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Ok. So the challenge is to write the necessary code in the kernel
> to build that DSO based on the various functions after detection
> of the CPU type.
> 
> Another option would be to pre-build a bunch of them at kernel compile
> time. I have to investigate. The risk is that we end up with too
> many combinations, thus bloating the kernel image.

You can create one "big" DSO which covers all the configured processors.
 Then at kernel start time, you determine the actual processor and
adjust the symbol table offsets to point to the correct version.  There
is no requirement that the table used is identical to the one on disk.
It's loaded into ordinary memory which can be modified.

The tricky part of this would be to determine the symbol table slots.
But even this is quite simple.  Just locate the symbol table in the
ELF-way, then iterate over the entries and use strcmp() for the names
and act upon match.  What you shouldn't do is to generate pointer to the
symbol table entries somewhere.  This is probably fragile and not worth
the few cycles you'll save.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
