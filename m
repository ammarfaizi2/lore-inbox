Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263855AbTCUTGf>; Fri, 21 Mar 2003 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263848AbTCUTFb>; Fri, 21 Mar 2003 14:05:31 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:33030 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263833AbTCUTFF>; Fri, 21 Mar 2003 14:05:05 -0500
Date: Fri, 21 Mar 2003 19:16:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030321191606.A7984@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20030321014048.A19537@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321014048.A19537@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Mar 21, 2003 at 01:40:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 01:40:48AM -0800, Adam J. Richter wrote:
> 	There have been some devfs clean ups in the stock kernels
> since 2.5.63, so here is a patch so that people have a version
> that applies cleanly:

A bunch of comments:

 - your docs mention devfs_only() buts it's gone for good now
 - you removed the last users of devfs_alloc_devnum()/devfs_dealloc_devnum(),
   please remove the functionality aswell (not exported anyway)
 - is the conditional call to init_devfs_fs() in devfs_decode() really
   nessecary?  I think one explicit call to it in the early boot
   process would be much better.  If you don't like that at least
   mark it unlikely()
 - why do you raise the capablities in devfs_register() and
   devfs_mk_symlink() (but not devfs_mk_dir()!).  I think any driver
   code actually calling that must run with raised privilegues already.
 - I think renaming base.c to interf{,ace}.c is a good idea.  It's
   more descriptive and will make the diff a lot easier to read.

