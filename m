Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbVBDQUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbVBDQUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbVBDQUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:20:02 -0500
Received: from ns.suse.de ([195.135.220.2]:49876 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261825AbVBDQTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:19:49 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: Andreas Gruenbacher <agruen@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16899.33676.414314.343747@alkaid.it.uu.se>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	 <1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.12681.98586.426731@alkaid.it.uu.se>
	 <1107513634.2245.46.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.29744.75308.6946@alkaid.it.uu.se>
	 <1107525405.2245.387.camel@sisko.sctweedie.blueyonder.co.uk>
	 <16899.33676.414314.343747@alkaid.it.uu.se>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107533948.17315.199.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Feb 2005 17:19:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 15:15, Mikael Pettersson wrote:

> Plain www.kernel.org kernels always.

Good, it's no bug then. Stephen already explained what's going on: when
a file has xattrs and you delete the file while running a kernel without
xattr support, the xattr block's refcount is not decremented. You end up
with a reference count that is one too high. This won't result in
filesystem corruption, but e2fsck will fix up the refcounts for you.
Those are the mesages you were getting.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

