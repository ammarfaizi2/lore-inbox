Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUFSUT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUFSUT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUFSUT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:19:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14045 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264627AbUFSUTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:19:24 -0400
Message-ID: <40D49FBC.7040900@pobox.com>
Date: Sat, 19 Jun 2004 16:19:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "R. J. Wysocki" <rjwysocki@sisk.pl>, Ricky Beam <jfbeam@bluetronic.net>
CC: Eric Buddington <ebuddington@verizon.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
References: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net> <200406192210.05455.rjwysocki@sisk.pl>
In-Reply-To: <200406192210.05455.rjwysocki@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

R. J. Wysocki wrote:
> On Saturday 19 of June 2004 01:06, Ricky Beam wrote:
> 
>>On Sat, 19 Jun 2004, R. J. Wysocki wrote:
>>
>>>Are your drives out of Seagate, maybe?  If not, what make are they?
>>
>>(As I said in a previous email...) 4 x Seagate ST3160023AS's RAID0'd
>>together in a BIOS "raid" mode compatable manner.
> 
> 
> Sorry, I should have noticed.
> 
> Anyway, it looks like a pattern is forming which smells bad to me.
> 
> Apparently, we have:
> 1) A serious error condition that occurs on Seagate SATA drives connected to 
> Silicon Image controllers.
> 2) As of today we can say that it only occurs on Seagate drives (Ricky, do I 
> remember correctly that you see faulty behavior of such drives with a 3ware 
> RAID?).
> 3) The error is reported by the kernel like that:


I wonder if it helps to add the Seagate drive to the sata_sil blacklist?

/* TODO firmware versions should be added - eric */
struct sil_drivelist {
         const char * product;
         unsigned int quirk;
} sil_blacklist [] = {
         { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
         { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
         { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
         { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
         { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
         { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
[...]

