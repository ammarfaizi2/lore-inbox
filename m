Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSFCGfK>; Mon, 3 Jun 2002 02:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317294AbSFCGfJ>; Mon, 3 Jun 2002 02:35:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39689 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317293AbSFCGfG> convert rfc822-to-8bit; Mon, 3 Jun 2002 02:35:06 -0400
Message-ID: <3CFB0063.3070309@evision-ventures.com>
Date: Mon, 03 Jun 2002 07:36:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: FUD or FACTS ?? but a new FLAME!
In-Reply-To: <Pine.LNX.4.10.10206021451310.5846-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> On Sun, 2 Jun 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> 
>>I apology for flames Andre, after some thinking I came to
>>conclusion that if speaking hardware you are generally right.
>>
>>I hope we can together resolve transport layer issues in 2.5.
> 
> 
> Bartlomiej,
> 
> Thanks, and we worked well in the past togather, and there has never been
> a communication problem with you.
> 
> Lets hope so, and please change the maintainer file to your name.
> As you were in mind in the past to replace me when I burned out.

O co chodzi? Po prostu powinno siê przenie¶æ dwa typy host chipów
intela do kategori - "mo¿e dzia³a jak chcesz to spróbuj":

Ulf Axelsson to wszystko dawno ju¿ rozwi±za³:

Hi Martin!

(Note: This mail (and myself) is intentionally _NOT_ intended to go anywhere
near linux-kernel and the regular flame fests. I'm as anonymous as one can
be ;-)

I have been reading the stuff about the difference between ATA/100 and
ATA/133 talking about clock cycles, buffer sizes, transmission directions
and what not and were quite unable to understand what the point was until I
looked at the public Intel ICH4 spec (the one available to us mortals
without connections :-)

ftp://download.intel.com/design/chipsets/manuals/29860002.pdf

Intel do state that the ICH4/82801DB supports only ATA/100 not ATA/133.
Looking through some reviews on the net on the 845E/G they do say the same
thing.

In the light of that perhaps the code in drivers/ide/piix.c stating that the
ICH4 does ATA/133 is a bit optimistic and should be moved to the "try it if
you want to " CONFIG_BLK_DEV_PIIX_TRY133 option.

Of course Vojtek might have better info that says otherwise.

<<<CUTOUT>>>
static struct piix_ide_chip {
         unsigned short id;
         unsigned char flags;
} piix_ide_chips[] = {
         { PCI_DEVICE_ID_INTEL_82801DB_9,        PIIX_UDMA_133 |
PIIX_PINGPONG },
                                                 ^^^^^^^^^^^^^

                     /* Intel 82801DB ICH4 */
         { PCI_DEVICE_ID_INTEL_82801CA_11,       PIIX_UDMA_100 |
PIIX_PINGPONG },
                     /* Intel 82801CA ICH3/ICH3-S */
         { PCI_DEVICE_ID_INTEL_82801CA_10,       PIIX_UDMA_100 |
PIIX_PINGPONG },
                     /* Intel 82801CAM ICH3-M */
         { PCI_DEVICE_ID_INTEL_82801E_9,         PIIX_UDMA_100 |
PIIX_PINGPONG },
<<<CUTOUT>>>

Things would be easier if "you know who" could just say that according to
public specs the ICH4 does not support ATA/133 instead of all that technical
talk......

Regards,
Ulf

PS. It would be kind if you could tell me where the source to the new
ide-info version you talked about can be found?



