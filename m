Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289566AbSAJRa5>; Thu, 10 Jan 2002 12:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289567AbSAJRau>; Thu, 10 Jan 2002 12:30:50 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:45259 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289566AbSAJRad>;
	Thu, 10 Jan 2002 12:30:33 -0500
Message-ID: <3C3DD034.9B2C83BD@inti.gov.ar>
Date: Thu, 10 Jan 2002 14:32:36 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: William Robison <william-robison@uiowa.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 
 entry
In-Reply-To: <3C3DB4A9.AADB16B0@uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Robison wrote:

>   Alan mentioned that some cards make use of multiple codecs,
> but also consider those of us that have multiple sound
> cards when forming the '/proc' pathname.  As a quick&dirty
> hack to allow two 1371 cards to co-exist in /proc, I added
> the upper 8 bits of the address into the filename...
>
>   (One sound card dedicated to being used as a 1200 baud
>    modem for AX25 work, leaving one free for use as a
>    normal soundcard)

My patch creates an entry that looks like it:

/proc/drivers/es1371/00:03.00/ac97

Where 00:03.00 is PCI bus == 00, 03 is card 3 of the bus and the last 00 is
feature/chip on the card == 00.
This name is the unique name of the card created by the pci part of the
kernel. Somebody pointed out that this will change to allow more than 256
elements, in this case the id will change and the module will create a
correct unique name.
If you have 2 boards in the same PCI bus it will look like it:

/proc/drivers/es1371/00:03.00/ac97
/proc/drivers/es1371/00:04.00/ac97

If you have a board with a chip that implements 2 ESS1371/CT5880/... will
look like it:

/proc/drivers/es1371/00:03.00/ac97
/proc/drivers/es1371/00:03.01/ac97

And if you have 2 boards in different PCI buses:

/proc/drivers/es1371/00:03.00/ac97
/proc/drivers/es1371/01:03.00/ac97

These are just examples but I think you get the idea and understand that
there is no problem. What Alan pointed out (and he is 100% right) is that the
same DC97 chip (ESS1371 for example) can have attached more than one AC97
codec (upto 4 according the spec) all using the AC-link communication. In
this case the PCI bus, card number and feature number is the same for all the
codecs. I'm resending a patch that will create it:

/proc/drivers/es1371/00:03.00/ac97-0
/proc/drivers/es1371/00:03.00/ac97-1

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



