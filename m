Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVHOXOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVHOXOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVHOXOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:14:30 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:996 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932559AbVHOXO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:14:29 -0400
Date: Tue, 16 Aug 2005 01:14:27 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Naveen Gupta <ngupta@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] remove use of pci_find_device in watchdog driver for Intel 6300ESB chipset
Message-ID: <20050815231426.GA19111@hardeman.nu>
References: <Pine.LNX.4.56.0508151425320.27212@krishna.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0508151425320.27212@krishna.corp.google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 02:30:15PM -0700, Naveen Gupta wrote:
[...}
>-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>-                if (pci_match_id(esb_pci_tbl, dev)) {
>-                        esb_pci = dev;
>-                        break;
>-                }
>-        }
>+	while (ids->vendor && ids->device) {
>+		if ((dev = pci_get_device(ids->vendor, ids->device, dev)) != NULL) {
>+			esb_pci = dev;
>+			break;
>+		}
>+		ids++;
>+	}

I'm certainly not sure about this, but the proposed while loop looks a 
bit unconventional, wouldn't something like:

for_each_pci_dev(dev)
	if (pci_match_id(esb_pci_tbl, dev)) {
		esb_pci = dev;
		break;
	}
}

be better?

//David
