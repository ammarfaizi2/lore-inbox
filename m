Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318420AbSGYLge>; Thu, 25 Jul 2002 07:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSGYLgd>; Thu, 25 Jul 2002 07:36:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54011 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318420AbSGYLgd>; Thu, 25 Jul 2002 07:36:33 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: martin@dalecki.de, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207250342410.4719-200000@master.linux-ide.org>
References: <Pine.LNX.4.10.10207250342410.4719-200000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 13:52:35 +0100
Message-Id: <1027601555.9489.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 11:51, Andre Hedrick wrote:
> I am sorry Alan, but I fixed all of the locking code in 2.4 a long time
> ago, and you adopted it somewhere around this patch.

Andre - the PCI probe fixes which this is about is something I wrote.
The other locking stuff which is unrelated to this discussion is your
code but thats not Im talking about - OK.

> Again I have to call this patch and fix and take credit and full ownership
> of removing all the save/cli/sti/restore which littered the driver and
> were spread like cow patties through a chopper gun.

That patch is wrong by the way because I made a mistake in 2.4. Your PCI
config locking should be using pci_config lock not io_request. I'll fix
the 2.4 tree in a bit now I've tidied up the 2.5 version.

> @@ -748,10 +737,8 @@
>  		bus_type = "VLB";
>  	} else {
>  		cmd640_vlb = 0;
> -		/*
> -		 * Don't leak I/O cycles on the PCI bus by blindly attempting
> -		 * a configuration cycle type that is not supported by the hardware.
> -		 */
> +		/* Find out what kind of PCI probing is supported otherwise
> +		   Justin Gibbs will sulk.. */


Just ask Justin Gibbs. He didn't like my comment 8) Im sure he remembers
who wrote it 8)



