Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVFGVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVFGVKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVFGVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:10:53 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:10257 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261970AbVFGVKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:10:40 -0400
Date: Tue, 7 Jun 2005 23:10:48 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050607211048.GO2369@mail.muni.cz>
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050607200820.GA25546@electric-eye.fr.zoreil.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 10:08:20PM +0200, Francois Romieu wrote:
> -> it does not match your 0006 revision. No wonder nothing gets detected.
> 
> As a quick hack, one could cross fingers and add a
> CH_DEVICE(6, 0, CH_BRD_N110_1F)
> 
> or, if it does not work:
> 
> CH_DEVICE(6, 1, CH_BRD_N210_1F)

I added:

enum {
        CH_BRD_T110_1F,
        CH_BRD_N110_1F,
        CH_BRD_N210_1F,
        CH_BRD_T210_1F,
};

struct pci_device_id t1_pci_tbl[] = {
        CH_DEVICE(6, 0, CH_BRD_T110_1F),
        CH_DEVICE(6, 1, CH_BRD_T110_1F),
        CH_DEVICE(7, 0, CH_BRD_N110_1F),
        CH_DEVICE(10, 1, CH_BRD_N210_1F),
        { 0, }
};

according to 2.6.6 driver. 

However, it seems to be highly unstable. Using iperf it gets broken. Card 
receives packets but it does not transmit after some iperf tests.

Using tcpdump I see things like this:
tcpdump -ni eth0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
23:05:03.854587 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 1
23:05:04.853853 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 2
23:05:05.853965 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 3
23:05:06.854079 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 4
23:05:07.854193 IP 10.0.0.1 > 10.0.0.2: icmp 64: echo request seq 5
 

> If it does not work at all, someone will have to dissect the whole
> thing. Please fill an entry at bugzilla.kernel.org, add it your lspci info
> and make it link the 2.6.6 driver from Chelsio's website.

Should I still add an bugzilla entry? Unfortunately, 2.6.6. driver from website
is accessible only through password.

-- 
Luká¹ Hejtmánek
