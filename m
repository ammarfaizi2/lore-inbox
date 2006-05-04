Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWEDDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWEDDQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWEDDQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:16:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:41006 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750901AbWEDDQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:16:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eKvbegX4nWKVoABEdsP9o62GSoLVDRjxIgUlbsZ/8YJOuGHDi0iWTPVOqMQ0cqP7WqxSiYK/xZV99OH8NyMRUNDPFNqlTKQe7/X5tt+IBP6MS1Ikd4XIHcFlDviXW5YtHICLImjioGaGwZXJpsAtIdyiSM9MXm6z84BkKyOYWIE=
Message-ID: <21d7e9970605032016w2a092ce9qb2bff38e739bca5@mail.gmail.com>
Date: Thu, 4 May 2006 13:16:37 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Rajesh Shah" <rajesh.shah@intel.com>
Subject: Re: i386/x86_84: disable PCI resource decode on device disable
Cc: gregkh@suse.de, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20060503152747.A29327@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060503152747.A29327@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> When a PCI device is disabled via pci_disable_device(), it's still
> left decoding its BAR resource ranges even though its driver
> will have likely released those regions (and may even have
> unloaded). pci_enable_device() already explicitly enables
> BAR resource decode for the device being enabled. This patch
> disables resource decode for the PCI device being disabled,
> making it symmetric with the enable call.
>
> I saw this while doing something else, not because of a
> problem report. Still, seems to be the correct thing to do.

I'm just wondering how this will react with VGA devices being run by
fbdev or the drm, I know the DRM never calls pci_disable_device, as
the card might require the bars enabled so it can do VGA, and which if
it is your primary VGA card, can cause you all kinds of troubles...
(like losing text mode)..

Alan Cox mentioned this somewhere before in relation to video cards..

Dave.
