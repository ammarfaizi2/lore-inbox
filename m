Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284258AbRL1XGS>; Fri, 28 Dec 2001 18:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRL1XGI>; Fri, 28 Dec 2001 18:06:08 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:42098 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284258AbRL1XGD>; Fri, 28 Dec 2001 18:06:03 -0500
Date: Fri, 28 Dec 2001 18:05:57 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228180557.B8216@redhat.com>
In-Reply-To: <20011228161223.A19069@thyrsus.com> <Pine.LNX.4.33.0112281417410.23445-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112281417410.23445-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 28, 2001 at 02:27:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 02:27:37PM -0800, Linus Torvalds wrote:
> and it's readable and probably trivially parseable into both the existing
> format (ie some "find . -name '*.conf'" plus sed-scripts) and into cml2 or
> whatever.

It's even doable within the .c file (and preferable for small drivers).  
Something like:

	/* mydriver.c .... header blah blah */
	config_requires(CONFIG_INET);
	config_option(CONFIG_MY_FAST_CHIP, "Help info for this");

which gets picked out of the .c files during depend phase, and nullified 
during compile by means of -Iconfig_system.h would even let us get rid of 
Makefiles for drivers.  Wouldn't being able to just drop a .c file (or a 
bunch of .c files) into the tree in the right place be great?  Eliminating 
makefiles means eliminating more conflicts, which might mean more time to 
respond to other issues...

		-ben
-- 
Fish.
