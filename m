Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbTIVLHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTIVLHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:07:33 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:21515 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263109AbTIVLHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:07:24 -0400
Date: Mon, 22 Sep 2003 12:07:22 +0100
From: John Levon <levon@movementarian.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-ID: <20030922110722.GB88127@compsoc.man.ac.uk>
References: <7F740D512C7C1046AB53446D372001730606B9@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730606B9@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1OXK-000OMu-N9*Knb1DZZWEPw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:59:21PM -0700, Villacis, Juan wrote:

> In some cases, a profiler can figure out information regarding
> Dynamically Generate Code (DGC) with help from the generator of the
> code, but in other cases it cannot.
> 
> In the case of Java jitted code, our userspace tools obtain sufficient
> information through JVMPI, when it is implemented by the JVM.

I would argue that any JVM that doesn't yet implement
JVMPI_EVENT_COMPILED_METHOD_LOAD is broken - JVMPI has been around for a
long time now.

I don't see why the kernel is the correct place to fix such lacking
functionality.

> for DGC which does not have such userspace support, it is important to
> be able to spot and accurately attribute samples to DGC.  The 4
> additional profiling hooks we proposed can be used for such purposes.

Please be specific about which *actual* cases you're worried about, and
why they shouldn't be fixed in userspace.

> If the generator of DGC frees memory used for DGC that subsequently gets
> a loaded image (or reuses memory that may have once had an executable
> image), you can mis-attribute samples so that instead of attributing the
> samples to the DGC, you will attribute the samples to an image. The
> dcookie mechanism will indicate information about an image, but doesn't
> help prevent mis-attribution of samples if DGC is intermixed with images
> that are loaded/unloaded in the same memory region.

Simply flush the sample buffer by echo 1 >/dev/oprofile/dump when you
receive a COMPILED_METHOD_LOAD/UNLOAD that conflicts with a previous
mapping.

regards
john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
