Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDEARi>; Wed, 4 Apr 2001 20:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDEAR3>; Wed, 4 Apr 2001 20:17:29 -0400
Received: from ns.suse.de ([213.95.15.193]:60170 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129624AbRDEARU>;
	Wed, 4 Apr 2001 20:17:20 -0400
Date: Thu, 5 Apr 2001 02:16:32 +0200
From: Andi Kleen <ak@suse.de>
To: hiren_mehta@agilent.com
Cc: alan@lxorguk.ukuu.org.uk, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: vmalloc on 2.4.x on ia64
Message-ID: <20010405021632.A9377@gruyere.muc.suse.de>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A08@xsj02.sjs.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A08@xsj02.sjs.agilent.com>; from hiren_mehta@agilent.com on Wed, Apr 04, 2001 at 06:11:32PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 06:11:32PM -0600, hiren_mehta@agilent.com wrote:
> I am calling during initialization only from detect() entry point.
> But I guess, before the detect() is called, scsi layer acquires
> the io_request_lock. So, you mean to say that I need to release it
> before calling vmalloc() ? I was doing the same thing on 2.2.x
> and even on 2.4.0 and it was working fine and now suddenly
> it stopped working on 2.4.2. So what are the guidelines for using
> vmalloc() if we want to use it in scsi low-level (HBA) driver ?
> I am currently using the new error handling code. (use_new_eh_code = TRUE).

It probably never worked correctly in all cases.

If you don't rely on the synchronization given by the io_request_lock you can
drop it around the vmalloc() call. 


-Andi
