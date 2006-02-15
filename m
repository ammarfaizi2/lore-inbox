Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWBOW2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWBOW2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWBOW2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:28:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751343AbWBOW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:27:59 -0500
Date: Wed, 15 Feb 2006 23:27:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Steve French <smfltc@us.ibm.com>,
       "linux-cifs-client@lists.samba.org" 
	<linux-cifs-client@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Additional questions on your hang
Message-ID: <20060215222757.GD5066@stusta.de>
References: <20050721115604.GB3160@stusta.de> <OF31F3CBF1.99DB2B76-ON87257046.0068484B-86257046.0068A410@us.ibm.com> <20050722191457.GL3160@stusta.de> <43F20EC0.8090305@us.ibm.com> <20060214171713.GA3513@stusta.de> <1139946851.9961.28.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139946851.9961.28.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:54:11PM -0600, Dave Kleikamp wrote:
>...
> I wasn't able to trace it to an exact line of code, but I think I see
> what the problem is.
> 
> This patch moves the copy_to_user from smb_read_data after the test
> whether smb_read_data is null.  It's good not to dereference a pointer
> if you have a reason to test it for null afterward.
> 
> This patch has not been compiled or tested.
>...

Thanks, this patch works fine for me and after disassembling it seems 
you've found exactly the place where the kernel Oops'ed for me in the 
forcedirectio case.

But even with this patch applied, I had a freeze in the 
non-forcedirectio case, although much later than usual.
There seems to be more than one bug.  :-(

I'm currently trying whether there are still any problems in the 
forcedirectio case, and I'll report back as soon as I am able to provide 
any additional information.

> David Kleikamp

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

