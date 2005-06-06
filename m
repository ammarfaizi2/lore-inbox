Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVFFVdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVFFVdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFFVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:33:09 -0400
Received: from hell.org.pl ([62.233.239.4]:9736 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261693AbVFFVc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:32:57 -0400
Date: Mon, 6 Jun 2005 23:32:48 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>
Cc: randy_dunlap <rdunlap@xenotime.net>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, julien.lerouge@free.fr
Subject: Re: Kernel oops with asus_acpi module
Message-ID: <20050606213248.GA22238@hell.org.pl>
Mail-Followup-To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>,
	randy_dunlap <rdunlap@xenotime.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	julien.lerouge@free.fr
References: <200506052340.41074.mail@hboeck.de> <200506061929.24663.mail@hboeck.de> <20050606114531.763eec37.rdunlap@xenotime.net> <200506062050.42632.mail@hboeck.de> <20050606135459.7ad699ae.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050606135459.7ad699ae.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote randy_dunlap:
> OK, I see that part.
> 
> I'm including a patch for you to try.  Can you apply and test it
> and report back on it, please?

May I see the DSDT? The Samsung P30 INIT method referenced in
asus_hotk_get_info() is not supposed to return anything, not even an empty
string. I believe the new ACPICA implicit return might be interfering. 
Here's the relevant part of what I based the code on:

Method (INIT, 1, NotSerialized)
{
    Store (One, ATKP)
    If (LNot (LLess (PCBV, 0x02)))
    {
        If (And (WBTF, 0x1F))
        {
            Or (WBTF, 0x20, WBTF)
        }

        And (WBTF, 0xE0, WBTF)
    }

    If (And (WBTF, 0x40))
    {
        If (And (WBTF, 0xBF))
        {
            WLED (0x81)
        }
        Else
        {
            WLED (0x80)
        }
    }
    Else
    {
        WLED (0x80)
    }
}

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
