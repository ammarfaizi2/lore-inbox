Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFPIzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFPIzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 04:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFPIzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 04:55:10 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:33868 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261212AbVFPIzA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 04:55:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tMlXiQZUVPuWPPPS56ectuLJC1zoxdQrt99GzEYx9hvuzuwStO+fu1ItYzez0o6in42oIHhA4HSPnpKS2LYvk0m+qOZIiWEf8QTiL73sg7eKOvRx55PtHLx+BqYm+Y+N/f1zQb1Ryr/DASfA1BR7B+ZMD1HnvJFuyQhr7IGAWsE=
Message-ID: <d73ab4d005061601555a2308d2@mail.gmail.com>
Date: Thu, 16 Jun 2005 16:55:00 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: guorke <gourke@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: mabye simple,but i confused
In-Reply-To: <20050616075400.GB57@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <d73ab4d005061522254f2e5933@mail.gmail.com>
	 <20050616075400.GB57@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes,DervishD.you give me a lot of help! Thanks

On 6/16/05, DervishD <lkml@dervishd.net> wrote:
>  * guorke <gourke@gmail.com> dixit:
> > in understangding the linux kernel, the authors says
> > "..Moves itself from address 0x00007c00 to address 0x00090000.."
> >
> > What i confused is why the Boot Loader do this, i asked google,but
> > still no answe.
> > who can make me understand it ?
> 
>    Well, let's start with the Master Boot Record. In PC's the BIOS
> loads the MBR at address 0x7c00, but the MBR is responsible for
> loading the OS bootsector, if any. And the bootsectors are written
> assuming that they're loaded by a MBR or *by the BIOS itself* so the
> address they assume is 0x7c00. But the MBR is already at that
> address! What can it do? Well, it moves itself out of the place.
> 
>    The problem is that the kernel itself could be loaded directly by
> the BIOS (a long time ago, it was possible to boot from a raw floppy
> containing an image of the kernel), and the first sector would be
> loaded at 0x7c00, so the bootsector, MBR, loader or whatever has to
> move out of that address at the very beginning. Why the physical
> address 0x00090000 was used? I don't know. Well, it's well at the top
> of the 640k base memory and the segment starts with 1001 in binary,
> which is a fancy number XDD
> 
>    Hope that helps.
> 
>    Raúl Núñez de Arenas Coronado
> 
> --
> Linux Registered User 88736 | http://www.dervishd.net
> http://www.pleyades.net & http://www.gotesdelluna.net
> It's my PC and I'll cry if I want to...
>
