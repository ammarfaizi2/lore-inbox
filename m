Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTLVX4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTLVX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:56:33 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:51865 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S264867AbTLVX41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:56:27 -0500
Date: Tue, 23 Dec 2003 00:56:23 +0100
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20031222235622.GA17030@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

Installing 2.6.0 I've found that some kernel options directives are wrong,
in fact the option turns out to be always enabled. I don't think this is 
a desired behaviour.

Sorry for the format, yes I know it's ugly :) but I'll leave to you the proper 
solution :) so I can't make a proper patch.


- IPV6_SCTP___ option is always turned on

./net/sctp/Kconfig:

8:  config IPV6_SCTP__
9: 	    tristate
10:         default y if IPV6=n
11:	    default IPV6 if IPV6
12:
13: config IP_SCTP
14:	    tristate "The SCTP Protocol (EXPERIMENTAL)"
15:	    depends on IPV6_SCTP__


I think something is wrong here, why the 'default y if IPV6=n' ???

 
- INPUT_MOUSEDEV option is always turned on

./drivers/input/Kconfig:

27: config INPUT_MOUSEDEV
28:	    tristate "Mouse interface" if EMBEDDED
29:	    default y
30:	    depends on INPUT

43: config INPUT_MOUSEDEV_PSAUX
44:         bool "Provide legacy /dev/psaux device" if EMBEDDED
45:         default y
46:         depends on INPUT_MOUSEDEV


the tristate directive is ignored in most default configurations since EMBEDDED
is not set, however this doesn't allow to disable INPUT_MOUSEDEV and 
INPUT_MOUSEDEV_PSAUX. I don't suppose this is right.


- SOUND_GAMEPORT option is always turned on

./drivers/input/gameport/Kconfig

22: config SOUND_GAMEPORT
23:         tristate
24:         default y if GAMEPORT!=m
25:         default m if GAMEPORT=m

line 24 is definetly wrong, option is enabled if GAMEPORT=n.


Bye 

P.S.
I'm not subscribed to this list so CC me if it's needed

--
------------------------------------------------------------
INFIS Network Administrator & Security Officer         .*. 
Department of Physics       - University of Trieste     V 
lcars@infis.univ.trieste.it - GPG Key 0x864C9B9E      (   )
----------------------------------------------------  (   )
"How would you know I'm mad?" said Alice.             ^^-^^
"You must be,'said the Cat,'or you wouldn't have come here."
------------------------------------------------------------
