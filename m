Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUDADDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 22:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUDADDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 22:03:25 -0500
Received: from pop.gmx.net ([213.165.64.20]:30689 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261437AbUDADDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 22:03:22 -0500
X-Authenticated: #21910825
Message-ID: <406B8721.6080104@gmx.net>
Date: Thu, 01 Apr 2004 05:06:09 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
CC: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjanv@redhat.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Device mapper devel list <dm-devel@redhat.com>,
       Thomas Horsten <thomas@horsten.com>, medley@lists.infowares.com
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com> <405CFC85.70004@backtobasicsmgmt.com> <20040321074711.GA13232@devserv.devel.redhat.com> <405D9CDA.6070107@gmx.at> <405F3B1C.3030500@gmx.net> <405F3EA8.6060606@pobox.com> <4060A8E0.7020905@gmx.at>
In-Reply-To: <4060A8E0.7020905@gmx.at>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> Jeff Garzik wrote:
> 
>> Carl-Daniel Hailfinger wrote:
>>
>>>> 4. nice clickety-click user interface
>>>> Especially useful for lazy people like me. ;)
>>>
>>>
>>>
>>>
>>> I prefer the "no user interface" approach. But then again, I'm biased.
>>
>>
>>
>> Agreed -- a minimal implementation is needed first anyway.  The BIOS
>> of these proprietary RAID thingies typically provides the user interface.
> 
> 
> On the other hand EVMS allowed me to make a minimal solution by taking
> care of the partitioning and the DM-API in the EVMS framework. The user

After having written a generic standalone solution (currently in testing)
with less code than the evms plugin, I have my doubts about EVMS allowing
minimal solutions. It seems most of your plugin is just code to make EVMS
happy and I was frightened by that.

> interface is just an add-on that comes with the package. Right now its
> just a way for the user to get a "look its really there". If we do the
> RAID configuration and writeing the configuration blocks to the disks or
> not is in your hands. When we consider this to be to risky then lets
> just skip it.

Please do not misunderstand my intentions. I appreciate your code very
much and tried to reuse as much of it as possible (and tried to keep my
modifications small), and if you plan on integrating my generic code into
EVMS you're most welcome (I would feel honoured).

However, my goals were (in that order):
1. Spit out a list of devices that have some sort of RAID magic
2. Group the devices by array
3. Set up a device corresponding to /dev/araraid/d0

and keep the code generic and independent enough so that it can be
integrated into EVMS or used standalone with only a few changes.

Code will follow once I get step 3 working generically.
Step 1 is done (I have some trouble finding the superblock on small
PDCRAID arrays, will ask Jeff).
Step 2 is done (modulo implementation bugs not yet found)
Step 3 is partly done (It only works for striped Highpoint arrays because
I didn't have the hardware available until now)


Regards,
Carl-Daniel

