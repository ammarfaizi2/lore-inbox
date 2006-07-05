Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWGEEih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWGEEih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGEEih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:38:37 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:60335 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932454AbWGEEig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:38:36 -0400
Message-ID: <44AB4243.8030002@myri.com>
Date: Wed, 05 Jul 2006 00:38:27 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent
 busses flags
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com> <20060704070643.GA16632@colo.lackof.org> <44AAF5D9.9040908@myri.com> <20060705034829.GA19937@colo.lackof.org>
In-Reply-To: <20060705034829.GA19937@colo.lackof.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> I still don't want the generic PCI code to assume a "root"
> PCI Host bus controller was found after that loop.

If I am not mistaken, we can use the following code to check whether we
found a root chipset:
        unsigned cap;
        u16 val;
        u8 ext_type;
        cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
        if (cap) {
                pci_read_config_word(pdev, cap + PCI_CAP_FLAGS, &val);
                ext_type = (val & PCI_EXP_FLAGS_TYPE) >> 4;
                if (ext_type == PCI_EXP_TYPE_ROOT_PORT)
                        <check no_msi flag>
        }

Brice

