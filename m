Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUJGPCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUJGPCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUJGPBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:01:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32019 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266316AbUJGPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:01:14 -0400
Date: Thu, 7 Oct 2004 16:01:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041007160108.B8579@flint.arm.linux.org.uk>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Earnshaw <Richard.Earnshaw@arm.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com> <20041005141452.B6910@flint.arm.linux.org.uk> <1097016532.32500.357.camel@localhost.localdomain> <41653814.1060405@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41653814.1060405@grupopie.com>; from pmarques@grupopie.com on Thu, Oct 07, 2004 at 01:35:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 01:35:32PM +0100, Paulo Marques wrote:
> The patch by Russel King seems ok to me, although I prefer Rusty's idea 
> of not using any symbol that is not in the form "[A-Za-z0-9_]+". We just 
> need to check if there are any real world users of these "weird" symbols.

This may filter out too much - we have symbols starting with a '.' on
ARM, particularly used in some of the assembly code, which are useful
to be decoded back to names, such as ".bug".

However, including "." means that names like "__func__.0" also get
included, which is probably a bad thing.  So, maybe it needs to be

[A-Za-z0-9_\.][A-Za-z0-9_]*

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
