Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUIGOmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUIGOmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIGOjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:39:03 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:47631 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268121AbUIGOfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:35:17 -0400
Date: Tue, 7 Sep 2004 14:35:09 +0000
To: Michal Ludvig <michal@logix.cz>
Cc: Andreas Happe <andreashappe@flatline.ath.cx>,
       James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040907143509.GA30920@old-fsckful.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
User-Agent: Mutt/1.5.6+20040523i
From: crow@old-fsckful.ath.cx (Andreas Happe)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 08:49:30PM +0200, Michal Ludvig wrote:
> I really like the patch - I wanted to do quite the same so thanks that you
> saved me some work ;-)

thanks ;).

> On Wed, 1 Sep 2004, Andreas Happe wrote:
> > the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie

BTW: the latest incarnation of the patch uses /sys/class/crypto/<cipher-name>.

> I'd prefer to have the algorithms grouped by "type" ("cipher", "digest",
> "compress")? Then the apps could easily see only the algos that thay are
> interested in...

jup, but the seqfile code in proc.c would get a lot more uglier. If we could
drop proc.c this wouldn´t be a problem.

> There could eventually be a separate crypto/sysfs.c, couldn't?

check the patch ;). There's already a sysfs.c with the sysfs-centric
stuff.

> Few notes:
> - - some algorithms allow only discrete set of keysizes (e.g. AES can do
> 128b, 192b and 256b). Can we instead of min/max have a file 'keysize' with
> either:
> 	minsize-maxsize
> or
> 	size1,size2,size3
> ?
> 
> - - ditto for blocksize?

how would you implement this in the crypto_alg struture? The sysfs/procfs
integration isn't that problem.

> - - With the future support for hardware crypto accelerators it
> might be possible to have more modules loaded providing the same
> algorithm. They may have different priorities and one would be treated as
> "default". Then I expect the syntax of 'module' file to change from a
> simple module name to something like:
> 	# modname:prio:type:whatever
> 	aes:0:generic:
> 	aes_i586:1:optimized:
> 	padlock:2:hardware:default

Isn't this against the "one value per file" - sysfs rule.

> Michal Ludvig

	--Andreas
