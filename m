Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274846AbTGaRIC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274852AbTGaRIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:08:02 -0400
Received: from [200.199.201.158] ([200.199.201.158]:7562 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S274846AbTGaRH7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:07:59 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to 2.6.0-test2
Date: Thu, 31 Jul 2003 16:32:56 -0300
User-Agent: KMail/1.5.9
Cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0307311710440.8394-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307311710440.8394-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200307311632.56813.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 July 2003 12:25, Bartlomiej Zolnierkiewicz wrote:
> What do you mean by "a lot more stable than before"?

I mean it doesn't crash the system during intensive read/write operations. It 
has something to do with limiting the max bk per request to 7.5 (hwif-
>rqsize=15).

> Can you separate your changes from forward-port?

They are really small changes. It's the one I mentioned on the first e-mail 
and this one, that was suggested by Andre Hedrick on another post:

	if(is_sata(hwif))
	{
+		drive->id->hw_config |= 0x6000;
		if(strstr(drive->id->model, "Maxtor"))
			return 3;
		return 4;
 	}

> Are you aware of side effect?
> [ Disabling DMA on ATAPI devices on SiI680. ]
>
> Please consult this change with Alan :-).

No, I'm not. Sorry. I'm look for more information. But dma is working with my 
SiI3112A, everything is stable, so maybe it should be enabled by default for 
this chipset.

Also, there's a change missing in this patch. The PCI id for SiI1210SA is 
missing in 2.6.x.

#define PCI_DEVICE_ID_SII_680      0x0680 
+#define PCI_DEVICE_ID_SII_1210SA   0x0240 
#define PCI_DEVICE_ID_SII_3112      0x3112

Anyway, thank you for taking a look at this.

Marcelo Penna Guerra
