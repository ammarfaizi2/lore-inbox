Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVBBIbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVBBIbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 03:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVBBIbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 03:31:03 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:2436 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261981AbVBBIa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 03:30:56 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel-janitors@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org, benh@kernel.crashing.org
Subject: Re: driver model u32 -> pm_message_t conversion: help needed
References: <20050125194710.GA1711@elf.ucw.cz>
From: Jes Sorensen <jes@wildopensource.com>
Date: 02 Feb 2005 03:30:55 -0500
In-Reply-To: <20050125194710.GA1711@elf.ucw.cz>
Message-ID: <yq0brb3qs74.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Hi!  Two Long time ago, BenH said that making patches is easy,
Pavel> so I hope to get his help now... And will probably need more.

Pavel> Suspend routines change, slowly.

Pavel> - int (*suspend)(struct device * dev, u32 state); + int
Pavel> (*suspend)(struct device * dev, pm_message_t state);

Pavel> For now u32 is typedef-ed to pm_message_t, but that is not
Pavel> going to be the case for 2.6.12. What needs to be done is
Pavel> changing all state parameters from u32 to
Pavel> pm_message_t. suspend() functions should not use state variable
Pavel> for now (except for PCI ones, those are allowed to call
Pavel> pci_choose_state and convert state into pci_power_t, and use
Pavel> that).

Pavel,

Sorry for being late responding to this, but I'd say this is a prime
example for typedef's considered evil (see Greg's OLS talk ;).

It would be a lot cleaner if it was made a struct and then passing a
struct pointer as the argument instead of passing the struct by value
as you do right now.

Pavel> -static int agp_via_suspend(struct pci_dev *pdev, u32 state)
Pavel> +static int agp_via_suspend(struct pci_dev *pdev, pm_message_t

Cheers,
Jes
