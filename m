Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292187AbSBPE5f>; Fri, 15 Feb 2002 23:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSBPE5P>; Fri, 15 Feb 2002 23:57:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292187AbSBPE5I>;
	Fri, 15 Feb 2002 23:57:08 -0500
Message-ID: <3C6DE6A1.2B5717BE@mandrakesoft.com>
Date: Fri, 15 Feb 2002 23:57:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: esr@thyrsus.com, Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <E16br21-0004Vw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Since the information is there in CML1 to generate the list of constraints
> for any given option, its a reasonable assertion that the entire CML2
> language rewrite is self indulgence from a self confessed language invention
> freak.

Correct me if I'm wrong, but there are express two different types of
situations, and CML1 isn't sufficient to express the second:

1) CONFIG_FOO_OPTION requires CONFIG_FOO

2) CONFIG_SUBSYS2 requires CONFIG_SUBSYS1

The reason why #2 is different, is the desired prompting and symbol
behavior for the end user.

If CONFIG_SUBSYS1=m or "", and CONFIG_SUBSYS2=y or m, then we gotta
change the value of CONFIG_SUBSYS1 and options underneath
CONFIG_SUBSYS1.  Re-prompt for CONFIG_SUBSYS1, perhaps?
If CONFIG_SUBSYS1=y, value of CONFIG_SUBSYS2 isn't affected
If CONFIG_SUBSYS1="" and CONFIG_SUBSYS2="", then we gotta prompt for
CONFIG_SUBSYS1, but -after- CONFIG_SUBSYS2 is prompted for.

I was tempted to introduce a "requires" token to express dependencies
between subsystems, because I feel they are different from the other
dependencies present, 

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
