Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277104AbRJLAE2>; Thu, 11 Oct 2001 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277103AbRJLAES>; Thu, 11 Oct 2001 20:04:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:31755 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277104AbRJLAEF>;
	Thu, 11 Oct 2001 20:04:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Over <ajo@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on removing via-rhine [2.4.10-ac11] 
In-Reply-To: Your message of "Thu, 11 Oct 2001 14:09:43 MST."
             <20011011140943.A10576@yeah.cx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 10:04:26 +1000
Message-ID: <32326.1002845066@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 14:09:43 -0700, 
Andrew Over <ajo@acm.org> wrote:
>This oops is reasonably easy to reproduce (reinsert and remove
>via-rhine enough times and it happens)
>>>EIP; c0129840 <__free_pages_ok+10/1c0>   <=====
>Trace; c01acd3e <pci_release_regions+6e/80>
>Trace; c0129f1a <__free_pages+1a/20>
>Trace; c0129f44 <free_pages+24/30>
>Trace; c010b6bc <pci_free_consistent+1c/20>
>Trace; e08fdbaa <_end+2066e636/20670a8c>
>Trace; e08fe860 <_end+2066f2ec/20670a8c>
>Trace; c01ad01e <pci_unregister_driver+3e/60>
>Trace; e08fdc0a <_end+2066e696/20670a8c>
>Trace; e08fe860 <_end+2066f2ec/20670a8c>

Oops in module delete may not get the symbol tables for the deleted
module if they have already been removed from /proc/ksyms.  I suggest
you create /var/log/ksymoops, man insmod.  Then insmod and rmmod will
save the symbol tables after each module load or unload, you can point
ksymoops at the saved symbols from before the failing rmmod.  That will
give a better ksymoops decode.

