Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283688AbRK3QH3>; Fri, 30 Nov 2001 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283691AbRK3QHS>; Fri, 30 Nov 2001 11:07:18 -0500
Received: from hermes.domdv.de ([193.102.202.1]:19205 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283688AbRK3QHJ>;
	Fri, 30 Nov 2001 11:07:09 -0500
Message-ID: <XFMail.20011130170443.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E169pzm-0003sq-00@the-village.bc.nu>
Date: Fri, 30 Nov 2001 17:04:43 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Deadlock on kernels > 2.4.13-pre6
Cc: linux-kernel@vger.kernel.org, <emmanuele.bassi@iol.it (Emmanuele Bassi)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this kind of deadlock on a MSI-6215 (i815) running in console mode (no X).
It always happened during screen blanking while there was interrupt load
(networking via ISDN). APM based screen blanking didn't work so I suspected APM
but at least this is only half true at maximum. The system does run fine with
APM but no APM screen blanking, if you disable console blanking completely by
issuing:

echo -n -e "\033[9;0]\033[10;0]\033[11;0]\033[14;0]"

during the boot sequence, i.e. output to /dev/console (beeps silenced too but I
do believe this can be ignored). By now I do suspect the console blanking code
to be the trigger of the lockup, not the APM code.

On 30-Nov-2001 Alan Cox wrote:
>> So far, I've excluded everything but a bug in the OSS sound drivers,
>> but, according to the ChangeLogs, they did not change from 2.4.13-pre6
>> (the last working kernel) to 2.4.13.
> 
> The OSS core and SB AWE driver have to all intents not changed since before
> 2.4 was released.
> 
> You might want to check when the  various VIA chipset fixes went in if you
> are using a VIA chipset
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
