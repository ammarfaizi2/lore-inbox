Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWDSVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWDSVsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDSVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:48:19 -0400
Received: from iron2-mx.tops.gwu.edu ([128.164.127.226]:64315 "EHLO
	iron2-mx.tops.gwu.edu") by vger.kernel.org with ESMTP
	id S1751255AbWDSVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:48:18 -0400
X-SenderBase: None
X-IronPort-AV: i="4.04,137,1144036800"; 
   d="scan'208"; a="228054260:sNHT25957038"
Date: Wed, 19 Apr 2006 17:48:17 -0400
From: Yuichi Nakamura <ynakam@gwu.edu>
To: Crispin Cowan <crispin@novell.com>
Cc: serue@us.ibm.com, garloff@suse.de, hch@infradead.org, gh@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-Id: <20060419174817.42cd2fca.ynakam@gwu.edu>
In-Reply-To: <4446A74F.5010100@novell.com>
References: <20060417225525.GA17463@infradead.org>
	<E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
	<20060418115819.GB8591@infradead.org>
	<20060418213833.GC5741@tpkurt.garloff.de>
	<20060419121034.GE20481@sergelap.austin.ibm.com>
	<e133c9da8fcba.8fcbae133c9da@gwu.edu>
	<4446A74F.5010100@novell.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 14:10:39 -0700
Crispin Cowan wrote:
> Does it label the file system as well? If not, then the path names you
> can specify with different access rights would be very limited. If so,
> then any change to the policy requires a relabellings.
Yes, files are labeled.
We make diff between before modification and after modification, 
and relabeles only files whose label definition have changed.
So it does not take much time to relabel.
 
> More than just sysfs. All network attached storage (NFS mounted file
> systems) cannot support xattr. One could imagine supporting xattr for
> Linux-based NFS servers, but that just won't work for non-linux storage
> servers.
I think it is correct.

> Suppose we want to write a profile for fingerd. In AppArmor, the rule
> would be "/home/*/.plan r" to grant read access to everyone's .plan
> file. Some people don't have a .plan file, but they do create them ad
> hoc as time goes on. What does seedit do in that case?
Now seedit can not resolve this by itself.
One solution is to watch file creation by "restorecond".
(restorecond: http://danwalsh.livejournal.com/4368.html)
But we have to create list of possible file names.

---
Yuichi Nakamura
