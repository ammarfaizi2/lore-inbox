Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUGNPzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUGNPzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUGNPzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:55:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:420 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267424AbUGNPxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:53:01 -0400
Message-ID: <40F556CE.9000707@pobox.com>
Date: Wed, 14 Jul 2004 11:52:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: akpm@osdl.org, dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
In-Reply-To: <200407141216.i6ECGHxg008332@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> gcc-3.4.1 errors out in 2.6.8-rc1-mm1 at drivers/scsi/sg.c:
> 
> drivers/scsi/sg.c: In function `sg_ioctl':
> drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call to 'sg_jif_to_ms': function body not available
> drivers/scsi/sg.c:930: sorry, unimplemented: called from here
> make[2]: *** [drivers/scsi/sg.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
> 
> sg_jif_to_ms() is marked inline but used defore its function
> body is available. Moving it nearer the top of sg.c (together
> with sg_ms_to_jif() for consistency) fixes the problem.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>


This looks like a compiler bug to me.

sg_jif_to_ms is properly declared at the top of the file...

 > static int sg_ms_to_jif(unsigned int msecs);
 > static inline unsigned sg_jif_to_ms(int jifs);
 > static int sg_allow_access(unsigned char opcode, char dev_type);

If gcc is insisting that prototypes for inlines no longer work, we have 
a lot of code churn on our hands ;-(  Grumble.

	Jeff


