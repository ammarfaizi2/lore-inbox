Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKUMn4>; Tue, 21 Nov 2000 07:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbQKUMnq>; Tue, 21 Nov 2000 07:43:46 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:48402 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129793AbQKUMna>; Tue, 21 Nov 2000 07:43:30 -0500
Date: Tue, 21 Nov 2000 07:13:27 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001121071327.R1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <14874.25691.629724.306563@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14874.25691.629724.306563@wire.cadcamlab.org>; from peter@cadcamlab.org on Tue, Nov 21, 2000 at 06:02:35AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 06:02:35AM -0600, Peter Samuelson wrote:
> 
> While trying to clean up some code recently (CONFIG_MCA, hi Jeff), I
> discovered that gcc 2.95.2 (i386) does not remove dead string
> constants:
> 
>   void foo (void)
>   {
>     if (0)
>       printk(KERN_INFO "bar");
>   }
> 
> Annoyingly, gcc forgets to drop the "<6>bar\0".  It shows up in the
> object file, needlessly clogging your cachelines.

gcc was never dropping such strings, I've commited a patch to fix this
a week ago into CVS.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
