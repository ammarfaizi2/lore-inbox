Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTAXWnu>; Fri, 24 Jan 2003 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAXWnt>; Fri, 24 Jan 2003 17:43:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22033 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264886AbTAXWns>;
	Fri, 24 Jan 2003 17:43:48 -0500
Message-ID: <3E31C36A.7040000@pobox.com>
Date: Fri, 24 Jan 2003 17:51:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ink@jurassic.park.msu.ru, Jeff.Wiedemeier@hp.com, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
References: <20030124163341.A4366@dsnt25.mro.cpqcorp.net>	<20030124.133434.66251483.davem@redhat.com>	<20030125014102.A825@localhost.park.msu.ru> <20030124.143252.97527503.davem@redhat.com>
In-Reply-To: <20030124.143252.97527503.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>    Date: Sat, 25 Jan 2003 01:41:02 +0300
>    
>    I don't understand the issue, really. The config register says:
>    "MSIs are enabled". Which means: "My platform is *really* going to
>    use MSI". Why do you want to ignore that?

Let us define "platform."  If you mean ia32 or alpha or sparc64, yes 
this is a quirk.  If you mean tg3, no, this is not a quirk.


> I see, why not code up a generic pci_using_msi(pdev) that
> does this?


Great minds think alike :)  This was going to be my suggestion:
call pci_using_msi(pdev), and require that it be called before 
pci_enable_device().

This fits Jeff's "disabling MSI at config time" AFAICS...

	Jeff



