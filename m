Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271272AbTHRGRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTHRGRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:17:10 -0400
Received: from f22.mail.ru ([194.67.57.55]:62214 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S271272AbTHRGRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:17:05 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=jw schultz=?koi8-r?Q?=22=20?= <jw@pegasys.ws>
Cc: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 18 Aug 2003 10:21:22 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually you have not answered his question.  And i think it
> a reasonable one.  It could be it was answered elsewhere.

No it was not answered. Yes you got this exactly. Aparently my
englisg is not as bad after all ... :)

>>>>> Question: how to configure udev so that "database" always refers to LUN 0
>>>>> on target 0 on bus 0 on HBA in PCI slot 1.
>>> Let's avoid this communication problem. You show me namedev.config line that 
>>> implements the above.

> I'll try to put slightly differently.  I'll concede that we
> cannot positionaly identify USB devices so lets set that
> aside for the nonce.  We can persistently, positionaly
> identify a device within the HBA context (BUS +ID + LUN) and
> should be able to do the same for a PCI HBA (PCI slot +
> device) or (PCI bridge topology).

actually you can. As Greg pointed out, topology rarely changes,
so it gives you enough information (of course if you constantly
add and remove USB hubs it becomes a bit of pain). But it has
the same problem - USB bus grows off PCI bus (usually) so adding
new USB controller possibly invalidates all configuration.

> So can i uniquely identify using persistent positional
> information a drive at PCI_slot=1, HBA_on_card=0, BUS=0,
> ID=1, LUN=0?  And how do i uniquely identify it in the udev
> config file so that adding the same model drive in the same
> BUS+ID+LUN on an same model HBA card in another PCI slot
> does not confuse the two?  If i cannot, can i at least do
> the identification so that adding ID=0,LUN=0 to the scsi buss
> doesn't cause a name change.

yep.

just to show what I expected from sysfs - here is entry from Solaris
/devices:

brw-r-----   1 root     sys       32,240 Jan 24  2002 /devices/pci@16,4000/scsi@5,1/sd@0,0:a

this entry identifies disk partition 0 on drive with SCSI ID 0, LUN 0
connected to bus 1 of controller in slot 5 of PCI bus identified
by 16. Now you can use whatever policy you like to give human
meaningful name to this entry. And if you have USB it will continue
further giving you exact topology starting from the root of your
device tree.

and this path does not contain single logical id so it is not subject
to change if I add the same controller somewhere else.

hopefully it clarifies what I mean ...

regards

-andrey
