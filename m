Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSE0ILp>; Mon, 27 May 2002 04:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSE0ILo>; Mon, 27 May 2002 04:11:44 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:23827 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S314285AbSE0ILn>;
	Mon, 27 May 2002 04:11:43 -0400
Message-ID: <3CF1EA3F.4070608@epfl.ch>
Date: Mon, 27 May 2002 10:11:43 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alessandro Morelli <alex@alphac.it>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: memory corruption with i815 chipset variant
In-Reply-To: <fa.mm4ng1v.vmenaj@ifi.uio.no> <fa.gciunnv.cnaf99@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
> That means its actually using the same GART code as the 440BX and friends
> if I remember rightly (the i815 special stuff is for on board video)


Alessandro reported the problem to me also. I went through the i815 
specs and found 2 'strange' things (maybe they are not but...)
1) No 'ERRSTS' register (well... a bus that does no error should be a 
feature ;-)
2) The ATTBASE register to which the *_configure functions write is 
different from other Intel chipsets. In the i815, the ATT base adress 
should be written between bits 12 and 28, whereas in all other Intel 
chipsets, it should be written between bits 12 and 31 (don't ask me why 
Intel feels like changing the adresses/specs for registers at each new 
chipsets....) .
Alan, do you think this could cause all those troubles ?

> 
>>Without agpgart module, kernel seems stable.  A naive (totally naive,
>>I admit it) interpretation suggests a problem in setting the AGP aperture.
> 
> 
> Does the ram survive memtest86 overnight with no errors logged if you boot
> memtest86 and just leave it ?

 From what Alessandro reported, it seems clear that the 'insmod agpgart' 
triggers the mayhem, including memtest failures.

Best regards

Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)


