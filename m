Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135953AbRDTQDm>; Fri, 20 Apr 2001 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135955AbRDTQDf>; Fri, 20 Apr 2001 12:03:35 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:35081 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135953AbRDTQDO>;
	Fri, 20 Apr 2001 12:03:14 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: German Gomez Garcia <german@piraos.com>
Date: Fri, 20 Apr 2001 18:01:59 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Problems with i2c-matroxfb and latest kernel
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A5B4671993@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Apr 01 at 20:31, German Gomez Garcia wrote:
>     After downloading latest 2.4.3-ac9 kernel and compiling it I found
> that when I insert the i2c-matroxfb module, the modprobe utility
> completely monopolize the system during about a minute everything gets
> really slow and it seems that it do something on the virtual consoles

Hi German,
  try it without connected monitor. It looks to me like that
DDC's SDA and SCL pins are connected to ground in your monitor
and/or your monitor cable. If they are stuck, it takes very long
before i2c code gives up (1s timeout; BTW, there is a bug,
adap->timeout in i2c_bit_add_bus should be set to HZ and not to 100,
if it is doing what I think it does... besides that I thought that
it is caller responsibility to set timeout).

  You should compile i2c-algo-bit as module and use insmod it
with 'bit_test=1' parameter. It should do some tests on these pins
to find whether they are stuck in 0 or in 1. You can also try
'i2c_debug=3' ...

  And last question - which matrox hardware do you have?
                                                    Thanks,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
