Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHXB6j>; Fri, 23 Aug 2002 21:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSHXB6j>; Fri, 23 Aug 2002 21:58:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315265AbSHXB6i>;
	Fri, 23 Aug 2002 21:58:38 -0400
Message-ID: <3D66E944.9080507@mandrakesoft.com>
Date: Fri, 23 Aug 2002 22:02:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andre Hedrick <andre@linux-ide.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208222014450.13077-100000@master.linux-ide.org> <20020823114433.10784@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Well... x86 PCs with ordinary BIOSes did. Other firmwares,
> embedded devices, whatever.... may not, or eventually the firmware
> will have reset everything prior to booting the kernel (go figure
> why, but that happens).
> 
> It's not difficult nor harmful to wait for that dawn busy bit to
> go away, so why not do it ?


Basically think about the consequences of trying to handle a completely 
unknown state -- if you are going to attempt to handle this you would 
need to check for data, not just the BSY bit.  And read the data into a 
throwaway buffer, if there is data to be read, or write the data it's 
expecting.

So it's not just the busy bit :)

