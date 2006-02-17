Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWBQLnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWBQLnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWBQLnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:43:24 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19455 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750886AbWBQLnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:43:23 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 17 Feb 2006 12:41:58 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F5B686.nail2VCA2A2OF@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <20060216115204.GA8713@merlin.emma.line.org>
 <43F4BF26.nail2KA210T4X@burner>
 <200602161742.26419.dhazelton@enter.net>
In-Reply-To: <200602161742.26419.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> At this point I, personally, am not aware of any.  However, after a careful 
> review of libscg in preparation for the patch I promised you, I can see that 
> it would be possible for the code to be rewritten so that just the linux 
> section contains the various workarounds that might be needed.
>
> With your refusal to even consider doing that I can see where some people get 
> this idea (I myself was under this exact same belief until I began my code 
> review in preparation for the proposed patch).

I am not refusing useful changes but I of course refuse to apply changes that
will or even may cause problems in the future.

cdrtools and libscg are a serious project and are maintained in a way that tries
to _plan_ all interfaces in a way that allows to upgrade interfaces for at 
least 10 years without a need for incompatible changes.


> I am unsure if you refused to provide OS specific workarounds for known bugs 
> in order to keep the code orthogonal,  or if you had another reason. But with 
> the division of the various operating system specific pieces of libscg into 
> seperate source files it doesn't make sense.

I like to have things orthogonal, but it seems that most people in LKML
do not understand implicit constraints from requiring orthogobality.


> Of the two bugs you've reported, one only exists in a deprecated and soon to 
> be removed module. I will try to fix the other one as soon as you can provide 
> me with enough data that I can see exactly what is getting messed up where.

Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If ide-scsi
ir removed, then a clean and orthogonal way of accessing SCSI in a generic
way is removed from Linux. If Linux does nto care about orthogonality of 
interfaces, this is a problem of the people who are responbile for the related
interfaces.


> As to you wanting to be able to read the SCSI status byte and the actual size 
> of the completed DMA... Those parts of the kernel are as close to a blackbox 
> to me as any code gets. Perhaps you could provide information or ideas on how 
> it could be managed?

This is another construction side in Linux.

In 1997, I did cleanly write dowen what exact features are missing to allow 
Linux to be used to _develop_ SCSI user space programs. I did even send a patch
for sg.c to the Linux folks. This patch extends the sg SCSI Generic interface
in a source AND binary, up AND downwards compatible way.

This patch has been rejected for unknown reasons and the fact that the source 
code fond in official Linux release has been changed in an incompatible way, it 
is impossible to apply it now.


My patch did enable sg.c to return more error/status information back to the 
user (e.g. the SCSI status byte) _and_ it defined a way to return DMA residual
counts to the user. If Linux still does not even have the DMA residual count 
internally available, this is a proof that nobody with sufficient SCSI know how
is willing to work on the Linux SCSI layer.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
