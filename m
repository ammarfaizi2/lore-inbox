Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310317AbSCPMmf>; Sat, 16 Mar 2002 07:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310316AbSCPMm0>; Sat, 16 Mar 2002 07:42:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:43025 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310309AbSCPMmU>;
	Sat, 16 Mar 2002 07:42:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speedup SMP kernel on UP box 
In-Reply-To: Your message of "Sat, 16 Mar 2002 06:51:35 CDT."
             <3C9331C7.5BDDE3BA@yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 23:42:10 +1100
Message-ID: <16495.1016282530@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 06:51:35 -0500, 
Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
>I had a think on this from the perspective of increasing UP performance
>of SMP kernels, and came up with the following rather interesting (IMHO)
>patch.  Executive summary is that when a SMP kernel finds itself on a UP
>box, it modifies itself (ooohh!) by going along and essentially doing a
>sed '_text,_etext s/lock/nop/'    :)
>
>Details:  Address of each relevant lock opcode is stored (similar to
>the way an exception table is)

Does your patch work with recent binutils?  I suspect that any lock
code in discarded exit sections will cause binutils to barf (loudly).
Look at the out of line changes to the lock code in 2.4.18-pre3, I had
to stop using a single lock section because of the more rigorous
binutils checks.

