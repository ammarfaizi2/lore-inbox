Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVDDUyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVDDUyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVDDUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:51:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:57059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261405AbVDDUtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:49:49 -0400
Message-ID: <4251A830.5030905@osdl.org>
Date: Mon, 04 Apr 2005 13:48:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, hadi@cyberus.ca, cfriesen@nortel.com, tgraf@suug.ch
Subject: Re: [PATCH] network configs: disconnect network options from drivers
References: <20050330234709.1868eee5.randy.dunlap@verizon.net> <20050331185226.GA8146@mars.ravnborg.org> <424C5745.7020501@osdl.org> <20050331203010.GA8034@mars.ravnborg.org> <4250B4C5.2000200@osdl.org> <20050404195051.GA12364@mars.ravnborg.org>
In-Reply-To: <20050404195051.GA12364@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam-

Sam Ravnborg wrote:
> On Sun, Apr 03, 2005 at 08:30:13PM -0700, Randy.Dunlap wrote:
> 
>>Any comments on this new version?
> 
> The new Networking menu looks unstructured.
> And the net/Kconfig file contains a lot of config snippets that does not
> belong there.
> So I took a stamp on it with focus on:
> - Move config bits to appropriate places, creating several new Kconfig
>   files
Very Good.

> - Made uses of menus more consistent at least on first and second level
Very Good again.

> - Move submenu to the top
> - Rename top menu to "Networking" and located it just before
>  "File systems"

I still prefer Networking to come before Device Drivers FWIW.
Just makes some kind of hierarchical sense to me.

> The patch became much larger. The win is that the top-level
> net/Kconfig contains much less cruft.
> 
> Many of the 56 lines added are due to the additional files.
> I did not (on purpose) change any functionality.
> 
> Only bit that I am worried about is the statement in SCTP:
> 	depends on IPV6 || IPV6=n
> 
> That looked like a noop to me. It had the sideeffect that SCTP
> menu entries where idented an extra level which was not desireable
> with currect layout.

Yeah, I was having several identation problems.

> Comments appreciated.

Nice job overall.  Especially nice to move ATM, bridge, DECNET,
ECONET, etc., to their own Kconfig files so that they are more
manageable.

I propose that the new file net/atm/Kconfig be sourced somewhere.

I'll look at it more to see if I have any other comments.

> Patch on top of rc2.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> 
> 	Sam
> 	
>  drivers/Kconfig               |    5 
>  drivers/net/Kconfig           |    5 
>  drivers/net/appletalk/Kconfig |   28 ++
>  net/8021q/Kconfig             |   21 +
>  net/Kconfig                   |  541 +++---------------------------------------
>  net/atm/Kconfig               |   77 +++++
>  net/bridge/Kconfig            |   32 ++
>  net/bridge/netfilter/Kconfig  |    1 
>  net/core/Kconfig              |   67 +++++
>  net/decnet/Kconfig            |   24 +
>  net/econet/Kconfig            |   34 ++
>  net/ipv4/netfilter/Kconfig    |    5 
>  net/ipv6/Kconfig              |   20 +
>  net/ipx/Kconfig               |   33 ++
>  net/lapb/Kconfig              |   24 +
>  net/packet/Kconfig            |   26 ++
>  net/sched/Kconfig             |   40 +++
>  net/sctp/Kconfig              |    5 
>  net/unix/Kconfig              |   22 +
>  net/wanrouter/Kconfig         |   31 ++
>  net/x25/Kconfig               |   35 ++
>  21 files changed, 567 insertions(+), 509 deletions(-)

Thanks!

-- 
~Randy
