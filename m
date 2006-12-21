Return-Path: <linux-kernel-owner+w=401wt.eu-S1423095AbWLUUyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423095AbWLUUyt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423094AbWLUUys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:54:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:2298 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423102AbWLUUyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:54:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ekcDhnTS16rDDVTuLYzatMwWu9TsvsdA10qbIZCajmAKUgD4Pq0exJPaxwtU+V+KanSaFQuJMimGkQBm8HIQLcemVTBDnSt/eW5Y9qj6AgivvY2MdL68hGGQ82ScFqFCuPzeFJ+K42ujLB+NPiO/MWCiYmx/vGnFvkNPMuYKCZE=
Date: Thu, 21 Dec 2006 20:53:11 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
Message-ID: <20061221205311.GB18827@slug>
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug> <458ADEDD.8010903@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458ADEDD.8010903@goop.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:22:05AM -0800, Jeremy Fitzhardinge wrote:
> Frederik Deweerdt wrote:
> > Following the i386 pda patches, it's not possible to set gs or fs value
> > from gdb anymore. The following patch restores the old behaviour of
> > getting and setting thread.gs of thread.fs respectively.
> > Here's a gdb session *before* the patch:
> > (gdb) info reg
> > [...]
> > fs             0x33     51
> > gs             0x33     51
> > (gdb) set $fs=0xffff
> > (gdb) info reg
> > [...]
> > fs             0x33     51
> > gs             0x33     51
> > (gdb) set $gs=0xffffffff
> > (gdb) info reg
> > [...]
> > fs             0xffff   65535
> > gs             0x33     51
> >
> > Another one *after* the patch:
> > (gdb) info reg
> > [...]
> > fs             0xd8     216
> >   
> 
> This doesn't look right.  This is the kernel's %fs, not usermode's
> (which should be 0).
> 
Right, I missed that.
> > gs             0x33     51
> > (gdb) set $fs=0xffff
> > (gdb) info reg
> > [...]
> > fs             0xffff   65535
> > gs             0x33     51
> > (gdb) set $gs=0xffff
> > (gdb) info reg
> > [...]
> > fs             0xffff   65535
> > gs             0xffff   65535
> >   
> Hm.  This shouldn't be possible since this is a bad selector, but I
> guess ptrace/gdb doesn't really know that.  If you run the target (even
> single step it), these should revert to 0.
I does, my point there is just that in that case gdb would stick the
0xffff value in the right place, which it doesn't without the patch.
> 
> > Andrew, this goes on top of ptrace-fix-efl_offset-value-according-to-i386-pda-changes.patch
> > sent by Jeremy yesterday.
> >   
> 
> Don't think this is quite right yet.  Assuming the %gs->%fs patch has
> been applied, then the target %fs should be on its stack, and target %gs
> will be in thread.gs.  I'm not sure that thread.fs has any use, but I'd
> want to double check vm86 to be sure.
I'm not sure what you mean by the '%gs->%fs patch'. Do you refer to 
convert-i386-pda-code-to-use-%fs-fixes.patch
which is in -mm1?
Or is there another one I might have missed? For the record, I'm running
-mm1 + the efl_offset patch.

Regards,
Frederik
> 
>     J
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
