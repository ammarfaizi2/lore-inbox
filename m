Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268828AbTCCVbM>; Mon, 3 Mar 2003 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268830AbTCCVbL>; Mon, 3 Mar 2003 16:31:11 -0500
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:9996 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S268828AbTCCVbD>; Mon, 3 Mar 2003 16:31:03 -0500
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <20BF5713E14D5B48AA289F72BD372D680326F892@AUSXMPC122.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: sam@ravnborg.org
cc: linux-kernel@vger.kernel.org
Subject: RE: [ANNOUNCE] DKMS: Dynamic Kernel Module Support
Date: Mon, 3 Mar 2003 15:41:20 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 127D138C702755-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It assume .o for modules, which is not true for 2.5.
> 
> When building a module it simply executes $MAKE - which is 
> plain wrong.
> As have been discussed in several threads you cannot reliably track
> changes in CFLAGS etc. without utilising the kbuild infrastructure.
> 

I will take up your suggestion and remove the assumptions that modules end
with .o.  I should note that we don't see 2.6 making it into production
environments within the next year so my focus has been solely on 2.4 at this
point.  Though, the kbuild infrastructure will actually mesh nicely with
DKMS as it will simplify the mess of makefiles that it has to deal with.  As
for $MAKE, I believe there is some confusion here.  $MAKE comes from
sourcing in the dkms.conf file which is required for each module in DKMS.
One of the directives in dkms.conf must be a MAKE which is the specific make
command needed to build your module.  So $MAKE should represent the right
thing to do for the module in question.

> DKMS is also highly connected to the usage of /lib/modules/...
> and naming of config files. It looks to me as it is very distribution
> specic.

DKMS is very intertwined with /lib/modules as this is where it installs
modules.  I was not aware that this was distro specific.  As for the kernel
config files, you are correct.  By default it does assume Red Hat's distro
specific scheme, but when building your module, you can pass a --config
option and specify the alternate path for your .config if it does not follow
this scheme.  I hope this clears this up.

Gary

