Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWDPSZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWDPSZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDPSZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 14:25:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1029 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750784AbWDPSZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 14:25:04 -0400
Date: Sun, 16 Apr 2006 20:24:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Dustin Kirkland <dustin.kirkland@us.ibm.com>,
       Kylene Jo Hall <kjhall@us.ibm.com>, kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
Message-ID: <20060416182459.GA4409@mars.ravnborg.org>
References: <1145027216.12054.164.camel@localhost.localdomain> <20060414170222.GA19172@thunk.org> <1145061219.4001.25.camel@localhost.localdomain> <20060415084058.GA29502@mars.ravnborg.org> <20060415150208.GB19708@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415150208.GB19708@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 11:02:08AM -0400, Theodore Ts'o wrote:
> On Sat, Apr 15, 2006 at 10:40:58AM +0200, Sam Ravnborg wrote:
> > The problem to be solved is the long time it takes to do
> > "make modules_install" when working on a single module.
> > Instead of bringing in more or less complex solutions what about
> > extending "make dir/module.ko" to include the installation of the
> > module.
> > 
> > Something like:
> > "make MI=1 dir/module.ko"
> > where MI=1 tells us to install the said module.
> 
> Um, wouldn't that imply that either (a) the compile is being done as
> root, or (b) the /lib/modules/* is writeable by a non-root userid?  I
> suppose the install command could be prefixed by sudo, but that seems
> awkward (and not everyone uses sudo).

kbuild has support for the above scenario already - I just forgot.
Say you are hacking ext3.
Do a successfull make and install all modules.
Manually remove the ext3 module from /lib/modules/...
And use the external module support in kbuild like this:

# Got to relevant directory
$> cd fs/ext3

# To build the module:
$> make -C ../.. M=`pwd`

# To install the module:
$> make -C ../.. M=`pwd` modules_install

	Sam
