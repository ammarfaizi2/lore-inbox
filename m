Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHFGdl>; Mon, 6 Aug 2001 02:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbRHFGdc>; Mon, 6 Aug 2001 02:33:32 -0400
Received: from venus.Sun.COM ([192.9.25.5]:49280 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S266977AbRHFGdT>;
	Mon, 6 Aug 2001 02:33:19 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <5443d56b01.56b015443d@mysun.com>
Date: Mon, 06 Aug 2001 08:23:49 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope the device still does not go out of suspend...
(lspci -s xx:xx.x -vvxxx output attched)

did I add the code in the right place?
near line 2161 in eepro100.c reads...
                  reinitialization;
                - serialization with other driver calls.
           2000/03/08  SAW */
added>  pci_set_power_state(pdev, 0);
        outw(SCBMaskAll, ioaddr + SCBCmd);
        speedo_resume(dev);


----- Original Message -----
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Date: Sunday, August 5, 2001 10:37 pm
Subject: Re: eepro100 2.4.7-ac3 problems (apm related)

> On Sat, 4 Aug 2001, Pawel Worach wrote:
> 
> > Sorry for the delay (vacation).
> > 
> > it seems to be the same problem (after reading a diff from the lspci
> > output (attached).
> > When i reload the module it seems to reset the adapters power state.
> 
> I see. It's still not really the same problem, though.
> 
> You could try to add a line
> 
>    pci_set_power_state(pdev, 0);
> 
> after the comment in eepro100_resume(). (Please let me know if it 
> fixes 
> the problem)
> 
> I suppose that should fix your problem. The driver doesn't support 
> suspend/resume completely yet, maybe I'll try to fix it - shouldn't 
> be too 
> hard.
> 
> --Kai

