Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbTIKP26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTIKP26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:28:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:53905 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261173AbTIKP2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:28:53 -0400
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030911082057.GP1396@suse.de>
References: <20030910114346.025fdb59.akpm@osdl.org>
	 <10720000.1063224243@flay>  <20030911082057.GP1396@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063294049.2967.30.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 16:27:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 09:20, Jens Axboe wrote:
> > need it. Is it unfixable? or just nobody's done it?
> 
> It's not unfixable, there's just not a lot of motivation to fix it since
> it's basically dead.

Almost all IDE tape drives require ide-scsi/st modules for one.  I'm not
sure of the problems in the 2.5 case, in the 2.4 case the big one was
that both IDE and SCSI want to control reset/recovery and reissue of
commands. That turns into a nasty mess and 2.4 now lets the IDE layer do
it, with SCSI just backing off. That may well be the right model for
2.5.x - ie the reset eh handler just waits for the IDE layer to kill the
command. The other one was races in the reset code which 2.4 I think now
has fixed, which will bite non scsi users but less often

