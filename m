Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTJSN7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 09:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTJSN7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 09:59:39 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:9104 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262156AbTJSN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 09:59:38 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Date: Sun, 19 Oct 2003 15:56:56 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
References: <20031015225055.GS17986@fs.tum.de.suse.lists.linux.kernel> <20031018105733.380ea8d2.akpm@osdl.org.suse.lists.linux.kernel> <p731xtapd4r.fsf@oldwotan.suse.de>
In-Reply-To: <p731xtapd4r.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310191556.56469.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Saturday 18 October 2003 21:19, Andi Kleen wrote:
> Best would be actually a mix of both - setting it case by case.
> That's already done in specific cases, e.g. ACPI is always compiled
> with -Os. This could be done for other files which are clearly
> slow path too.

If there is is guarantee fro the GCC Steering Comitee, that there will
never be any ABI changes generated from the differences there (like
structure padding on/off).

Maybe there should be sth. in the build system for that, which is called
$(call optimize_for_speed, $target) and $(call optimize_for_size,$target) 
which then can be added on a per file basis and per directory tree,
where it really matters and letting it to the default otherwise.

That way we can tune gradually and remove GCC options.

Simple implementation today:

optimize_for_speed := CFLAGS_$1 += -O3
optimize_for_size  := CFLAGS_$1 += -Os


Sam: What do you think?

Regards

Ingo Oeser


