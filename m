Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTH0Jmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTH0Jmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:42:45 -0400
Received: from fep01.swip.net ([130.244.199.129]:7660 "EHLO fep01-svc.swip.net")
	by vger.kernel.org with ESMTP id S263266AbTH0Jmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:42:42 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: generate modprobe.conf
Date: Wed, 27 Aug 2003 11:42:40 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271142.40104.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried generate modprobe.conf from my modules.conf, but without success.
My ethernet card and mouse doesn't work - theitr modules are not loaded in 
startup. Where is problem?

My modules.conf:

keep

alias eth0 3c59x
options 3c59x 3c509x debug=0 options=4,8

post-install bttv insmod tuner
post-remove bttv rmmod tuner


alias char-major-10-175 agpgart
alias char-major-10-200 tun
alias char-major-81     bttv
alias char-major-108    ppp_generic
alias /dev/ppp          ppp_generic
alias tty-ldisc-3       ppp_async
alias tty-ldisc-14      ppp_synctty
alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate

alias loop-xfer-gen-0   loop_gen
alias loop-xfer-3       loop_fish2
alias loop-xfer-gen-10  loop_gen
alias cipher-2          des
alias cipher-3          fish2
alias cipher-4          blowfish
alias cipher-6          idea
alias cipher-7          serp6f
alias cipher-8          mars6
alias cipher-11         rc62
alias cipher-15         dfc2
alias cipher-16         rijndael
alias cipher-17         rc5

alias net-pf-31 bluez
alias bt-proto-0 l2cap
alias bt-proto-2 sco
alias bt-proto-4 bnep
alias tty-ldisc-15 hci_uart
alias char-major-10-250 hci_vhci
alias bt-proto-3 rfcomm

alias char-major-81 videodev
alias char-major-81-0 bttv
pre-install bttv modprobe -k msp3400; modprobe -k tuner
options bttv radio=0 card=64
options tuner type=19

options ide-cd ignore=hdd            # tell the ide-cd module to
                                     #  ignore hdd
alias scd0 sr_mod                    # load sr_mod upon access
                                     #  of scd0
pre-install sg     modprobe ide-scsi # load ide-scsi before sg
pre-install sr_mod modprobe ide-scsi # load ide-scsi before sr_mod
pre-install ide-scsi modprobe ide-cd # load ide-cd   before
                                     #  ide-scsi
alias char-major-13 hid
post-install hid modprobe -k mousedev; modprobe -k input

alias /dev/ppp          ppp_generic
alias char-major-108    ppp_generic
alias tty-ldisc-3       ppp_async
alias tty-ldisc-14      ppp_synctty
alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate

"setserial-module reload"
 "setserial-module uload"

alias /dev/tts          serial
alias /dev/tts/0        serial
alias /dev/tts/1        serial
alias /dev/tts/2        serial
alias /dev/tts/3        serial
post-install serial /etc/init.d/setserial modload > /dev/null 2> /dev/null
pre-remove serial /etc/init.d/setserial modsave  > /dev/null 2> /dev/null

alias parport_lowlevel parport_pc
alias char-major-10-144 nvram
alias binfmt-0064 binfmt_aout
alias char-major-10-135 rtc

