Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUI1Mff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUI1Mff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUI1Mff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:35:35 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:21764 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S267651AbUI1Mec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:34:32 -0400
Date: Tue, 28 Sep 2004 14:34:26 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Michal Ludvig <michal@logix.cz>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, Andreas Happe <crow@old-fsckful.ath.cx>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040928123426.GA21069@final-judgement.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz> <20040910105502.GA4663@final-judgement.ath.cx> <20040927084149.GA3625@final-judgement.ath.cx> <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Ludvig <michal@logix.cz> [040927 11:32]:
>BTW In http://lists.logix.cz/pipermail/cryptoapi/2004/000088.html I
>described a concept of "preferences" that was done for the current
>cryptoapi. How to do something similar with your patch applied?

The class - objects are used just for display use.. your patch should
apply (sans offsets) without problems.. I don't think that the two
different algorithms would be displayed in sysfs as i use the cra_name
as directory name (which should be aes for aes and aes-i586).

>If I'd finally have two or more modules for the same algorithm loaded, how
>should the /sys subtree look like?

good one.

If there are lots of different implementation for a given algorithm it
could be worthwhile to create a algorithm and a implementation -
directory e.g.

ls /sysfs/class/crypto/implementations would list:
aes-i586 aes-c4 md5 sha1 sha256-c4

and: ls /sysfs/class/crypto/algorithms
aes

with ls /sysfs/class/crypto/algorithms/aes
name type implementations

where implementations is a directory with links to the given
implementations in /sysfs/class/crypto/implementations.

Seems like a lot of work if there are only few implementations (like aes
and aes-i586).

the same could be done without the implementations - directory. If a new
algorithm tries to register itself with a already registered name (and
the module name isn't known) it is added to the
/sysfs/class/crypto/<cra-name>/implementations - directory as
<module-name>. All Algorithm - specific data would be displayed in the
<cra-name> directory, the rest in the implementations/<module-name> -
directory.

I'm moving to vienna the day after tomorrow so don't expect too fast
response times from me.

	--Andreas
