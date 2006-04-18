Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWDRTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWDRTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWDRTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:50:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932285AbWDRTu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:50:26 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: Crispin Cowan <crispin@novell.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <44453E7B.1090009@novell.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>
	 <44453E7B.1090009@novell.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 21:50:12 +0200
Message-Id: <1145389813.2976.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
> Karl MacMillan wrote:
> > Which is one reason why SELinux has types (equivalence classes) - it
> > makes it possible to group large numbers of applications or resources
> > into the same security category. The targeted policy that ships with
> > RHEL / Fedora shows how this works in practice.
> >   
> AppArmor (then called "SubDomain") showed how this worked in practice
> years before the Targeted Policy came along. The Targeted Policy
> implements an approximation to the AppArmor security model, but does it
> with domains and types instead of path names, imposing a substantial
> cost in ease-of-use on the user.

I would suspect that the "filename" thing will be the biggest achilles
heel...
after all what does filename mean in a linux world with
* hardlinks
* chroot
* namespaces
* bind mounts
* unlink of open files
* fd passing over unix sockets
* relative pathnames
* multiple threads (where one can unlink+replace file while the other is
in the validation code)

