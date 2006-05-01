Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWEANu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWEANu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWEANu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:50:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7099 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932108AbWEANu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:50:56 -0400
Subject: Re: [PATCH 0/4] MultiAdmin LSM
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
References: <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <1145462454.3085.62.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
	 <20060419201154.GB20545@kroah.com>
	 <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
	 <20060421150529.GA15811@kroah.com>
	 <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 01 May 2006 15:50:44 +0200
Message-Id: <1146491444.20760.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2. A small problem
> ==================
> As cool as it may sound, I think the implementation is not as clean as
> possible.
> 
> Let's pick a random starting point: The subadmin is allowed to call
> drivers/char/lp.c:lp_ioctl():LPGETSTATS. Or
> fs/quota.c:generic_quotactl_valid():Q_GET*/Q_XGET*. For that to work
> without too much code changes, CAP_SYS_ADMIN must be given to the
> subadmin.
> 
> However, CAP_SYS_ADMIN (others are affected too, but this is the main one)
> is used for other things too (mostly write or ioctl operations), which is
> actually something that should not be granted to the subadmin.
> 
> This poses a problem. Currently, it is solved by adding an extra LSM hook,
> security_cap_extra(), called from capable(). The hooked function then
> looks at current->*uid/*gid and returns 1 or 0, depending on whether an
> action is allowed or not. For more details see patch #1.
> 
> 


I wonder if we should just split up CAP_SYS_ADMIN then...
that might end up being the most simple solution...


