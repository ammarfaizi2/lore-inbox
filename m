Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVEMP3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVEMP3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVEMP3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:29:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:19157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262297AbVEMP3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:29:36 -0400
Message-ID: <4284C7DA.1020707@pobox.com>
Date: Fri, 13 May 2005 11:29:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Ketrenos <jketreno@linux.intel.com>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: git repository for net drivers available
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com>
In-Reply-To: <4284C54E.3060907@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ketrenos wrote:
> Jeff Garzik wrote:
> 
> 
>>This includes the wireless-2.6 repository.
>>
>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>>
>>The main branch is fairly irrelevant, as you must choose the branch
>>you wish:
>>
>>
>>>[jgarzik@pretzel netdev-2.6]$ ls .git/branches/
>>>8139cp         e1000        ixgb     r8169            skge          
>>>we18
>>>8139too-iomap  forcedeth    janitor  register-netdev  smc91x        
>>>wifi
>>>amd8111        ieee80211    orinoco  remove-drivers   smc91x-eeprom
>>>e100           iff-running  ppp      sis900           starfire
>>
> Ok, I'll bite.  Hopefully I'm not the only one tripping on shoe laces...
> 
> Here is what I did -- what am I doing wrong?
> 
> Following is using cogito 0.10:
> 
> REPO=rsync://rsync.kernel.org/pubs/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> cg-clone ${REPO}
> .... get coffee, etc. ... come back and I have a netdev-2.6 tree ...
> cg-branch-add wifi ${REPO}#wifi
> cg-update wifi
> .... connects and attempts to download but fails out with:
> 
> ----------------
> receiving file list ... done
> client: nothing to do: perhaps you need to specify some filenames or the
> --recursive option?
> 
> rsync: link_stat
> "/scm/linux/kernel/git/jgarzik/netdev-2.6.git/heads/wifi" (in pub)
> failed: No such file or directory (2)

Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
using $repo/branches/$branch.

You can achieve what's necessary with

> rsync --verbose --delete --stats --progress \
> -a rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git/ .git

and then

> ( cd .git ; rm -f HEAD ; ln -s branches/wifi HEAD )

and then

> git-read-tree $(cat .git/HEAD) && git-checkout-cache -q -f -a && git-update-cache --refresh



For what it's worth, this is only netdev-2.6 as it appeared in 
BitKeeper.  I am only now merging all the emailed patches since BK devel 
stopped into git, which includes the ipw code you submitted.

	Jeff


