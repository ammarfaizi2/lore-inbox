Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319331AbSHQDUg>; Fri, 16 Aug 2002 23:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319333AbSHQDUf>; Fri, 16 Aug 2002 23:20:35 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42704 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S319331AbSHQDUf>; Fri, 16 Aug 2002 23:20:35 -0400
Date: Fri, 16 Aug 2002 22:24:32 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: harish.vasudeva@amd.com
cc: linux-kernel@vger.kernel.org
Subject: Re: need help with pci_module_init
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F285D0@caexmta9.amd.com>
Message-ID: <Pine.LNX.4.44.0208162222480.849-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 harish.vasudeva@amd.com wrote:

>  pci_module_init() works fine only the first time i load my driver.
> subsequent loads will fail with this call returning -19!! any clues?

-19 is -ENODEV, i.e. pci_module_init() doesn't find any devices that match 
your driver. That's most likely since they're still considered owned by 
the previously loaded driver (your module as well), which forgot to 
pci_unregister_driver() at unload time.

--Kai


