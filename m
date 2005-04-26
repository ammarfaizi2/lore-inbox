Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVDZKQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVDZKQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVDZKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:13:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39344 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261443AbVDZKJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:09:58 -0400
Date: Tue, 26 Apr 2005 11:09:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426100953.GB30762@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu> <20050426095608.GA30554@infradead.org> <E1DQMsX-0000IX-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQMsX-0000IX-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 12:01:17PM +0200, Miklos Szeredi wrote:
> And for the first part, please _explain_ why you think it's crap.

Problem 1:

 - you're mounting things into the global namespace, but expect it only
   be visible to a certain subset of processes.  these processes are also
   not specicified by a tradition unix session / process group / etc but
   against all the process attributes we have based on the uid

Problem 2, which is related:

 - in fuse you're re-routing filesystem request to userspace, so fine so good
 - mount is currently a privilegued operation, and expects a privilegued
   filesystem implementation, not an ordinary user
 - to bypass that you have a suid mount wrapper
 - now you need various hacks to make sure this can't be used by other users

in short you are hacking around the namespace management which sits above
the filesystems in a rather broken way.
