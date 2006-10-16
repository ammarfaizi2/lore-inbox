Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWJPQIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWJPQIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWJPQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:08:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:64938 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422706AbWJPQIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:08:36 -0400
Message-ID: <4533AE82.6010502@suse.de>
Date: Mon, 16 Oct 2006 18:08:34 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: caglar@pardus.org.tr, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoid PIT SMP lockups
References: <1160170736.6140.31.camel@localhost.localdomain>	 <200610111349.32231.caglar@pardus.org.tr>	 <1160589556.5973.1.camel@localhost.localdomain>	 <200610112137.01160.caglar@pardus.org.tr> <1160592235.5973.5.camel@localhost.localdomain>
In-Reply-To: <1160592235.5973.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Hey Gerd,
> 	Looks like the smp replacements code in 2.6.18 is breaking with vmware.
> I'm guessing we're taking an interrupt while apply_replacements is
> running. Any ideas?

It's not the smp alternatives code, its the one for processor-specific
instructions.  The eip offset for alternative_instructions() in the
trace suggests it is the first call to apply_replacements.  The second
one is the one for the smp alternatives (which doesn't do anything btw
as we patch away the lock prefixes only).

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
