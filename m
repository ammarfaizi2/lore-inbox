Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTDIFlz (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbTDIFlz (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:41:55 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:39159 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262740AbTDIFly (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:41:54 -0400
Date: Tue, 8 Apr 2003 23:53:04 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-ID: <20030408235304.T1422@schatzie.adilger.int>
Mail-Followup-To: Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org
References: <3E93A958.80107@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E93A958.80107@si.rr.com>; from fdavis@si.rr.com on Wed, Apr 09, 2003 at 01:02:16AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 09, 2003  01:02 -0400, Frank Davis wrote:
> I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and 
> 2.5.x, I believe) that I believe would be helpful. Currently, printk 
> messages are all in english, and I was wondering if printk could be 
> modified to print out user messages that are in the default language of 
> the machine. For example,
> 
> printk(KERN_WARN "This driver is messed up!\n", 'en'); //Prints the 
> english text .
> 
> printk(KERN_WARN "This driver is messed up!\n", 'wel'); //Prints the 
> welsh translation of the english text.
> 
> printk(KERN_WARN "This driver is messed up!\n", getdefaultlanguage());
> 
> I'm looking for a possible uniform design to make this happen, short of 
> adding a complete machine translation module to the kernel. :) Userland 
> internationalization support is already provided(I haven't personally 
> used other languages besides English, but I've seen the options), but a 
> kernel module or printk addition that handles localized kernel messages 
> seems reasonable.
> 
> Thoughts, comments?

I don't think you will get support from anyone for non-english messages
in the kernel.  Some people think there is already too much text segment
in the kernel (c.f. tests that show kernel size shrinks by 200kB or whatever
when printk is defined to a no-op).

There was a proposal to make printks be more generic/consistent by someone
at IBM, but I don't know what happened to it.

My suggestion would be to add the required i18n support to klogd, so that
kernel messages are translated as they are removed from dmesg into syslog.
Then, like any i18n support, you build a message catalog from the printk
strings in the kernel and have klogd do the lookups/translation in user
space.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

