Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSDKRdK>; Thu, 11 Apr 2002 13:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSDKRdJ>; Thu, 11 Apr 2002 13:33:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34294 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S312619AbSDKRdI>; Thu, 11 Apr 2002 13:33:08 -0400
Date: Thu, 11 Apr 2002 13:33:07 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: taka@valinux.co.jp, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020411133307.B20895@redhat.com>
In-Reply-To: <20020411.154651.51706443.taka@valinux.co.jp> <20020410.234821.122842406.davem@redhat.com> <20020411.164134.85392767.taka@valinux.co.jp> <20020411.005216.107061041.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 12:52:16AM -0700, David S. Miller wrote:
> I think this idea has such high overhead that it is even not for
> consideration, consider SMP.

One possibility is to make the inode semaphore a rwsem, and to have NFS 
take that for read until the sendpage is complete.  The idea of splitting 
the inode semaphore up into two (one rw against truncate) has been bounced 
around for a few other reasons (like allowing multiple concurrent reads + 
writes to a file).  Perhaps its time to bite the bullet and do it.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
